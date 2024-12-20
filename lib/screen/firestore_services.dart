import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get missing persons
  Stream<List<Map<String, dynamic>>> getMissingPersons() {
    return _db.collection('missing_persons').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList(),
        );
  }

  // Get found persons
  Stream<List<Map<String, dynamic>>> getFoundPersons() {
    return _db.collection('found_persons').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList(),
        );
  }
}
