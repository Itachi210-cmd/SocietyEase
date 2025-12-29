import 'package:flutter/material.dart';
import '../../core/widgets/violation_card.dart';

class ViolationDetailScreen extends StatelessWidget {
  final Violation violation;
  const ViolationDetailScreen({super.key, required this.violation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Violation #${violation.id}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              violation.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Chip(label: Text(violation.status)),
            const Divider(height: 32),
            const Text(
              'Submitted On',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(violation.date),
          ],
        ),
      ),
    );
  }
}