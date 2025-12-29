import 'package:flutter/material.dart';

// ✅ Updated Model to hold all necessary data
class StaffMember {
  String name;
  String role;
  String imageUrl;
  String address;
  int daysPresent;
  int daysAbsent;
  bool isPresent;

  StaffMember({
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.address,
    required this.daysPresent,
    required this.daysAbsent,
    this.isPresent = true,
  });
}

class StaffCard extends StatelessWidget {
  final StaffMember staff;
  final VoidCallback onTapped; // For opening the detail screen
  final Function(bool) onStatusChanged; // For marking present/absent

  const StaffCard({
    super.key,
    required this.staff,
    required this.onTapped,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        onTap: onTapped, // Make the whole card tappable
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(staff.imageUrl),
        ),
        title: Text(staff.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(staff.role),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ Interactive Present/Absent Buttons
            IconButton(
              icon: Icon(Icons.check_circle, color: staff.isPresent ? Colors.green : Colors.grey),
              onPressed: () => onStatusChanged(true),
              tooltip: 'Mark Present',
            ),
            IconButton(
              icon: Icon(Icons.cancel, color: !staff.isPresent ? Colors.red : Colors.grey),
              onPressed: () => onStatusChanged(false),
              tooltip: 'Mark Absent',
            ),
          ],
        ),
      ),
    );
  }
}