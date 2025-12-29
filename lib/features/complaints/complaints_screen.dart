import 'package:flutter/material.dart';
import '../../core/widgets/complaint_card.dart';
import 'complaint_detail_screen.dart';

import '../../data/services/firestore_service.dart';
import '../../data/models/complaint_model.dart';
import '../../core/widgets/shimmer_loading.dart';

class ComplaintsScreen extends StatelessWidget {
  const ComplaintsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Complaints')),
      body: StreamBuilder<List<Complaint>>(
        stream: FirestoreService().getComplaints(), // Use the service
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ComplaintListSkeleton();
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No complaints found.'));
          }

          final activeComplaints = snapshot.data!;
          return ListView.builder(
            itemCount: activeComplaints.length,
            itemBuilder: (context, index) {
              final complaint = activeComplaints[index];
              return ComplaintCard(
                complaint: complaint,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ComplaintDetailScreen(complaint: complaint)),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/new_complaint'),
        label: const Text('New Complaint'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}