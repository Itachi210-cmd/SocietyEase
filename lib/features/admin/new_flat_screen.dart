import 'package:flutter/material.dart';
import 'flat_occupancy_screen.dart'; // Import the Flat model

class NewFlatScreen extends StatefulWidget {
  const NewFlatScreen({super.key});
  @override
  State<NewFlatScreen> createState() => _NewFlatScreenState();
}

class _NewFlatScreenState extends State<NewFlatScreen> {
  final _flatNumberController = TextEditingController();

  void _addFlat() {
    if (_flatNumberController.text.isEmpty) return;

    final newFlat = Flat(
      number: _flatNumberController.text,
      status: 'Vacant', // New flats are vacant by default
    );
    // Send the new flat object back to the previous screen
    Navigator.pop(context, newFlat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Flat')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _flatNumberController,
              decoration: const InputDecoration(labelText: 'Flat Number (e.g., C-401)'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _addFlat,
              child: const Text('Add Flat'),
            ),
          ],
        ),
      ),
    );
  }
}