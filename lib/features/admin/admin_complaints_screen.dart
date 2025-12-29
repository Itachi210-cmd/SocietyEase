import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/widgets/complaint_card.dart';
import '../../data/models/complaint_model.dart';

class AdminComplaintsScreen extends StatelessWidget {
  const AdminComplaintsScreen({super.key});

  // Function to show a dialog to change the complaint status
  void _showStatusUpdateDialog(BuildContext context, Complaint complaint) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Update Complaint Status'),
        content: Text('Update status for complaint from User ID: ${complaint.userId.substring(0, 6)}...'),
        actions: [
          TextButton(
            onPressed: () {
              // Update status to 'In Progress' in Firestore
              FirebaseFirestore.instance.collection('complaints').doc(complaint.id).update({'status': 'In Progress'});
              Navigator.of(ctx).pop();
            },
            child: const Text('In Progress'),
          ),
          TextButton(
            onPressed: () {
              FirebaseFirestore.instance.collection('complaints').doc(complaint.id).update({'status': 'Resolved'});
              Navigator.of(ctx).pop();
            },
            child: const Text('Resolved'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage All Complaints'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // ✅ Stream ALL complaints from the collection, not just for one user
        stream: FirebaseFirestore.instance
            .collection('complaints')
            .orderBy('submittedAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No complaints have been submitted yet.'));
          }
          final complaintDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: complaintDocs.length,
            itemBuilder: (context, index) {
              final complaint = Complaint.fromFirestore(complaintDocs[index]);
              return ComplaintCard(
                complaint: complaint,
                onTap: () => _showStatusUpdateDialog(context, complaint),
              );
            },
          );
        },
      ),
    );
  }
}