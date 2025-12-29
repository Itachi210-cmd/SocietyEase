import 'package:flutter/material.dart';

import '../../core/widgets/staff_card.dart'; // For the StaffMember model

class EditStaffScreen extends StatefulWidget {
  final StaffMember staff;
  const EditStaffScreen({super.key, required this.staff});

  @override
  State<EditStaffScreen> createState() => _EditStaffScreenState();
}

class _EditStaffScreenState extends State<EditStaffScreen> {
  late final TextEditingController _presentController;
  late final TextEditingController _absentController;

  @override
  void initState() {
    super.initState();
    _presentController = TextEditingController(text: widget.staff.daysPresent.toString());
    _absentController = TextEditingController(text: widget.staff.daysAbsent.toString());
  }

  @override
  void dispose() {
    _presentController.dispose();
    _absentController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    // Update the staff member object with the new values
    final updatedStaff = widget.staff;
    updatedStaff.daysPresent = int.tryParse(_presentController.text) ?? widget.staff.daysPresent;
    updatedStaff.daysAbsent = int.tryParse(_absentController.text) ?? widget.staff.daysAbsent;

    // Send the updated object back to the detail screen
    Navigator.pop(context, updatedStaff);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${widget.staff.name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _presentController,
              decoration: const InputDecoration(labelText: 'Days Present'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _absentController,
              decoration: const InputDecoration(labelText: 'Days Absent'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}