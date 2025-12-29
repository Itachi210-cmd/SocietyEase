import 'package:flutter/material.dart';
import '../../core/widgets/staff_card.dart';
import 'staff_detail_screen.dart'; // ✅ Import the new detail screen

class StaffAttendanceScreen extends StatefulWidget {
  const StaffAttendanceScreen({super.key});

  @override
  State<StaffAttendanceScreen> createState() => _StaffAttendanceScreenState();
}

class _StaffAttendanceScreenState extends State<StaffAttendanceScreen> {
  // ... _staffList is the same ...
  final List<StaffMember> _staffList = [
    StaffMember(name: 'Priya Sharma', role: 'Maid', imageUrl: 'https://i.pravatar.cc/150?img=1', address: 'A-101, Rose Apartments', daysPresent: 22, daysAbsent: 2),
    StaffMember(name: 'Ramesh Singh', role: 'Security', imageUrl: 'https://i.pravatar.cc/150?img=2', address: 'B-203, Tulip Towers', daysPresent: 24, daysAbsent: 0),
    StaffMember(name: 'Suresh Kumar', role: 'Gardener', imageUrl: 'https://i.pravatar.cc/150?img=3', isPresent: false, address: 'C-305, Orchid Heights', daysPresent: 20, daysAbsent: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Attendance'),
        // ... actions ...
      ),
      body: Column(
        // ... date ...
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _staffList.length,
              itemBuilder: (context, index) {
                final staff = _staffList[index];
                return StaffCard(
                  staff: staff,
                  onStatusChanged: (isPresent) {
                    setState(() {
                      staff.isPresent = isPresent;
                    });
                  },
                  onTapped: () {
                    // ✅ This now navigates to the detail screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StaffDetailScreen(staff: staff),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      // ... floating action button ...
    );
  }
}