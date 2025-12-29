import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewViolationScreen extends StatefulWidget {
  const NewViolationScreen({super.key});
  @override
  State<NewViolationScreen> createState() => _NewViolationScreenState();
}

class _NewViolationScreenState extends State<NewViolationScreen> {
  String? _selectedType;
  final _descriptionController = TextEditingController();
  bool _isLoading = false;

  Future<void> _submitReport() async {
    if (_selectedType == null || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields.')));
      return;
    }
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You must be logged in.')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Save the report to Firestore
      await FirebaseFirestore.instance.collection('violations').add({
        'title': '$_selectedType Violation',
        'description': _descriptionController.text,
        'status': 'Open',
        'userId': user.uid,
        'submittedAt': Timestamp.now(),
      });
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: ${e.toString()}')));
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Report a Violation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              items: const [
                DropdownMenuItem(value: 'Noise', child: Text('Noise Complaint')),
                DropdownMenuItem(value: 'Parking', child: Text('Parking Violation')),
                DropdownMenuItem(value: 'Pet', child: Text('Pet Policy Violation')),
                DropdownMenuItem(value: 'Other', child: Text('Other')),
              ],
              onChanged: (value) => _selectedType = value,
              decoration: const InputDecoration(labelText: 'Violation Type'),
            ),
            const SizedBox(height: 16),
            TextField(controller: _descriptionController, decoration: const InputDecoration(labelText: 'Description'), maxLines: 4),
            const SizedBox(height: 24),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
              onPressed: _submitReport,
              child: const Text('Submit Report'),
            ),
          ],
        ),
      ),
    );
  }
}