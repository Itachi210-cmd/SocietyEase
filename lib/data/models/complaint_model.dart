import 'package:cloud_firestore/cloud_firestore.dart';

class Complaint {
  final String id;
  final String userId;
  final String category;
  final String description;
  final String status;
  final DateTime submittedAt;

  Complaint({
    required this.id,
    required this.userId,
    required this.category,
    required this.description,
    required this.status,
    required this.submittedAt,
  });

  // Factory constructor to create a Complaint from a Firestore document
  factory Complaint.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Complaint(
      id: doc.id,
      userId: data['userId'] ?? '',
      category: data['category'] ?? 'General',
      description: data['description'] ?? '',
      status: data['status'] ?? 'Pending',
      submittedAt: (data['submittedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  // Convert Complaint to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'category': category,
      'description': description,
      'status': status,
      'submittedAt': Timestamp.fromDate(submittedAt),
    };
  }
}
