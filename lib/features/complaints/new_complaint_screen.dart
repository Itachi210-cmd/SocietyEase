import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../data/models/complaint_model.dart';
import '../../data/services/firestore_service.dart';

class NewComplaintScreen extends StatefulWidget {
  const NewComplaintScreen({super.key});

  @override
  State<NewComplaintScreen> createState() => _NewComplaintScreenState();
}

class _NewComplaintScreenState extends State<NewComplaintScreen> {
  final _descriptionController = TextEditingController();
  String? _selectedCategory;
  bool _isLoading = false;

  final List<String> _categories = ['Maintenance', 'Security', 'Admin', 'Other'];

  Future<void> _submitComplaint() async {
    if (_selectedCategory == null || _descriptionController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a category and enter a description.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      final userId = user?.uid ?? 'anonymous';

      final newComplaint = Complaint(
        id: '', // Firestore will generate this if we use .add(), but our model expects it.
        // Actually FirestoreService.addComplaint uses .add() which ignores the ID in the map if we don't include it.
        // We can leave it empty, or change the service to use .doc().set().
        // For now, let's just pass empty string, the ID in Firestore doc will be the real ID.
        userId: userId,
        category: _selectedCategory!,
        description: _descriptionController.text.trim(),
        status: 'Open',
        submittedAt: DateTime.now(),
      );

      await FirestoreService().addComplaint(newComplaint);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Complaint submitted successfully!')),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting complaint: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lodge a New Complaint')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: _categories.map((category) {
                return DropdownMenuItem(value: category, child: Text(category));
              }).toList(),
              onChanged: (value) => setState(() => _selectedCategory = value),
              decoration: const InputDecoration(labelText: 'Complaint Category'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 5,
            ),
            const SizedBox(height: 24),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
              onPressed: _submitComplaint,
              child: const Text('Submit Complaint'),
            ),
          ],
        ),
      ),
    );
  }
}