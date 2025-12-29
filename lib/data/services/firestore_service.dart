import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/complaint_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Collection Reference
  CollectionReference get _complaintsRef => _db.collection('complaints');

  // Add a new complaint
  Future<void> addComplaint(Complaint complaint) async {
    try {
      // Use the toMap method to convert the object
      await _complaintsRef.add(complaint.toMap());
    } catch (e) {
      print('Error adding complaint: $e');
      rethrow;
    }
  }

  // Get stream of complaints (for real-time updates)
  Stream<List<Complaint>> getComplaints() {
    return _complaintsRef
        .orderBy('submittedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Complaint.fromFirestore(doc))
        .toList());
  }
}
