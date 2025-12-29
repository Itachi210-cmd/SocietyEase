import 'package:flutter/material.dart';
import '../../core/widgets/visitor_card.dart'; // Import the simple Visitor model

class PreApproveGuestScreen extends StatefulWidget {
  const PreApproveGuestScreen({super.key});

  @override
  State<PreApproveGuestScreen> createState() => _PreApproveGuestScreenState();
}

class _PreApproveGuestScreenState extends State<PreApproveGuestScreen> {
  final _nameController = TextEditingController();

  void _preApproveGuest() {
    if (_nameController.text.isEmpty) {
      // Show an error if the name is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a name.')),
      );
      return;
    }

    // Create a new Visitor object with the entered name
    final newVisitor = Visitor(
      name: _nameController.text,
      arrivalTime: 'Pre-approved', // Set the status
      imageUrl: 'https://i.pravatar.cc/150?img=5', // A random placeholder image
    );

    // Send the new visitor object back to the previous screen
    Navigator.pop(context, newVisitor);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pre-approve a Guest')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Guest Name'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _preApproveGuest,
              child: const Text('Pre-approve'),
            )
          ],
        ),
      ),
    );
  }
}