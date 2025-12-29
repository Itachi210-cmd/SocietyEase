import 'package:flutter/material.dart';
import '../../core/widgets/violation_card.dart';

class RuleViolationsScreen extends StatelessWidget {
  const RuleViolationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data
    final List<Violation> reportedViolations = [
      Violation(title: 'Noise Complaint', id: '12345', date: 'Oct 26, 2025', status: 'In Review'),
      Violation(title: 'Parking Violation', id: '67890', date: 'Oct 25, 2025', status: 'Resolved'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Rule Violations')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Report a Violation'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: reportedViolations.length,
              itemBuilder: (context, index) {
                return ViolationCard(violation: reportedViolations[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}