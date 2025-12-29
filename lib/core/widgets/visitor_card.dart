import 'package:flutter/material.dart';

// Simple model for dummy data
class Visitor {
  final String name;
  final String arrivalTime;
  final String imageUrl;

  Visitor({
    required this.name,
    required this.arrivalTime,
    required this.imageUrl,
  });
}

class VisitorCard extends StatelessWidget {
  final Visitor visitor;
  const VisitorCard({super.key, required this.visitor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(visitor.imageUrl),
        ),
        title: Text(visitor.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Arrived: ${visitor.arrivalTime}'),
        trailing: const Text(
          'Entered',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}