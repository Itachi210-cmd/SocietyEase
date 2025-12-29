import 'package:flutter/material.dart';

import '../../core/widgets/staff_card.dart'; // For the StaffMember model
import 'edit_staff_screen.dart'; // We will create this screen next

class StaffDetailScreen extends StatefulWidget {
  final StaffMember staff;
  const StaffDetailScreen({super.key, required this.staff});

  @override
  State<StaffDetailScreen> createState() => _StaffDetailScreenState();
}

class _StaffDetailScreenState extends State<StaffDetailScreen> {
  late StaffMember _staffMember;

  @override
  void initState() {
    super.initState();
    _staffMember = widget.staff;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_staffMember.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              // Navigate to the edit screen and wait for a result
              final updatedStaff = await Navigator.push<StaffMember>(
                context,
                MaterialPageRoute(
                  builder: (context) => EditStaffScreen(staff: _staffMember),
                ),
              );

              // If the edit screen returns updated data, refresh the UI
              if (updatedStaff != null) {
                setState(() {
                  _staffMember = updatedStaff;
                });
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(_staffMember.imageUrl),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              _staffMember.role,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
          const Divider(height: 32),
          ListTile(
            leading: const Icon(Icons.location_on_outlined),
            title: const Text('Address'),
            subtitle: Text(_staffMember.address),
          ),
          ListTile(
            leading: const Icon(Icons.check_circle_outline, color: Colors.green),
            title: const Text('Days Present'),
            trailing: Text(
              _staffMember.daysPresent.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.cancel_outlined, color: Colors.red),
            title: const Text('Days Absent'),
            trailing: Text(
              _staffMember.daysAbsent.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}