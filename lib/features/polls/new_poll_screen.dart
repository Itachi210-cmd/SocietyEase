import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class NewPollScreen extends StatefulWidget {
  const NewPollScreen({super.key});
  @override
  State<NewPollScreen> createState() => _NewPollScreenState();
}

class _NewPollScreenState extends State<NewPollScreen> {
  final _titleController = TextEditingController();
  bool _isLoading = false;

  Future<void> _publishPoll() async {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a title.')));
      return;
    }
    setState(() => _isLoading = true);

    try {
      // Save the new poll to a 'polls' collection
      await FirebaseFirestore.instance.collection('polls').add({
        'title': _titleController.text,
        'status': 'Voting ends in 7 days', // Placeholder status
        'isActive': true,
        'results': {'Yes': 0, 'No': 0}, // Initial results
        'createdAt': Timestamp.now(),
      });
      if (mounted) Navigator.pop(context);
    } catch (e) {
      // ... error handling
    }
    if (mounted) setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create New Poll')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Poll Question')),
            const SizedBox(height: 24),
            // In a more advanced version, you could add fields here for custom options
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(onPressed: _publishPoll, child: const Text('Publish Poll')),
          ],
        ),
      ),
    );
  }
}