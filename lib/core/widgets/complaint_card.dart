import 'package:flutter/material.dart';
import '../../data/models/complaint_model.dart';

class ComplaintCard extends StatelessWidget {
  final Complaint complaint;
  final VoidCallback onTap;
  const ComplaintCard({super.key, required this.complaint, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'complaint_${complaint.id}',
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Material(
          type: MaterialType.transparency, // Needed for Hero text rendering
          child: ListTile(
            title: Text(complaint.category, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(complaint.description, maxLines: 1, overflow: TextOverflow.ellipsis),
            trailing: Text(
              complaint.status,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: complaint.status == 'Resolved' ? Colors.green : Colors.orange,
              ),
            ),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
