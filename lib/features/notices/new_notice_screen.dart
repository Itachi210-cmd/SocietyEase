import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class NewNoticeScreen extends StatefulWidget {
  const NewNoticeScreen({super.key});
  @override
  State<NewNoticeScreen> createState() => _NewNoticeScreenState();
}

class _NewNoticeScreenState extends State<NewNoticeScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String? _selectedCategory;
  bool _isLoading = false;

  Future<void> _publishNotice() async {
    if (_selectedCategory == null || _titleController.text.isEmpty || _contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields.')));
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Save the new notice to the 'notices' collection
      await FirebaseFirestore.instance.collection('notices').add({
        'title': _titleController.text,
        'category': _selectedCategory,
        'content': _contentController.text,
        'timestamp': Timestamp.now(),
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
      appBar: AppBar(title: const Text('Publish New Notice')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(controller: _titleController, decoration: const InputDecoration(labelText: 'Title')),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              hint: const Text('Select Category'),
              value: _selectedCategory,
              items: ['General', 'Maintenance', 'Events', 'Security']
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedCategory = value),
            ),
            const SizedBox(height: 16),
            TextField(controller: _contentController, decoration: const InputDecoration(labelText: 'Content'), maxLines: 8),
            const SizedBox(height: 24),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(onPressed: _publishNotice, child: const Text('Publish Notice')),
          ],
        ),
      ),
    );
  }
}