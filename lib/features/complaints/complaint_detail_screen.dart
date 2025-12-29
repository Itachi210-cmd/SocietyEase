import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/complaint_model.dart';

class ComplaintDetailScreen extends StatelessWidget {
  final Complaint complaint;
  const ComplaintDetailScreen({super.key, required this.complaint});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('dd MMM, yyyy').format(complaint.submittedAt);
    return Scaffold(
      appBar: AppBar(title: const Text('Complaint Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Hero(
              tag: 'complaint_${complaint.id}',
              child: Material(
                type: MaterialType.transparency,
                child: Text(complaint.category, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text(complaint.status),
              backgroundColor: Colors.orange.withOpacity(0.2),
              labelStyle: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 32),
            const Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(complaint.description),
            const Divider(height: 32),
            const Text('History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: const Text('Report Submitted'),
              subtitle: Text(formattedDate),
            ),
          ],
        ),
      ),
    );
  }
}