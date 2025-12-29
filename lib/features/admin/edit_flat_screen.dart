import 'package:flutter/material.dart';
import 'flat_occupancy_screen.dart'; // Import the Flat model

class EditFlatScreen extends StatefulWidget {
  final Flat flat;
  const EditFlatScreen({super.key, required this.flat});

  @override
  State<EditFlatScreen> createState() => _EditFlatScreenState();
}

class _EditFlatScreenState extends State<EditFlatScreen> {
  late final TextEditingController _flatNumberController;

  @override
  void initState() {
    super.initState();
    _flatNumberController = TextEditingController(text: widget.flat.number);
  }

  void _saveChanges() {
    if (_flatNumberController.text.isEmpty) return;

    final updatedFlat = widget.flat;
    updatedFlat.number = _flatNumberController.text;

    Navigator.pop(context, updatedFlat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Flat Number')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _flatNumberController,
              decoration: const InputDecoration(labelText: 'Flat Number'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveChanges,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}