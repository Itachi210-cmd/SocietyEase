import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewStaffScreen extends StatefulWidget {
  const NewStaffScreen({super.key});
  @override
  State<NewStaffScreen> createState() => _NewStaffScreenState();
}

class _NewStaffScreenState extends State<NewStaffScreen> {
  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  final _addressController = TextEditingController();
  bool _isLoading = false;

  Future<void> _addStaffMember() async {
    if (_nameController.text.isEmpty || _roleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all required fields.')));
      return;
    }
    setState(() => _isLoading = true);

    await FirebaseFirestore.instance.collection('staff').add({
      'name': _nameController.text,
      'role': _roleController.text,
      'address': _addressController.text,
      'imageUrl': 'https://i.pravatar.cc/150?img=${DateTime.now().millisecond}',
      'daysPresent': 0,
      'daysAbsent': 0,
      'isPresent': true,
    });

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Staff')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'Full Name')),
            const SizedBox(height: 16),
            TextFormField(controller: _roleController, decoration: const InputDecoration(labelText: 'Role')),
            const SizedBox(height: 16),
            TextFormField(controller: _addressController, decoration: const InputDecoration(labelText: 'Address')),
            const SizedBox(height: 24),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(onPressed: _addStaffMember, child: const Text('Add Staff Member')),
          ],
        ),
      ),
    );
  }
}