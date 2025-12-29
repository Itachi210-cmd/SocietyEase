import 'package:flutter/material.dart';

// Simple model
class Violation {
  final String id;
  final String title;
  final String date;
  final String status;

  Violation({
    required this.id,
    required this.title,
    required this.date,
    required this.status,
  });
}

class ViolationCard extends StatelessWidget {
  final Violation violation;
  const ViolationCard({super.key, required this.violation});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(violation.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('#${violation.id} • ${violation.date}'),
        trailing: Text(violation.status, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}