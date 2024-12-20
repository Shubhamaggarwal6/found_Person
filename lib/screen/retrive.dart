import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>> getMissingPersonImageUrls() async {
  try {
    // Retrieve all missing persons from Firestore
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('missing_persons').get();
    List<String> imageUrls = [];

    for (var doc in snapshot.docs) {
      // Add the image URL to the list
      imageUrls.add(doc['image_url']);
    }

    return imageUrls;
  } catch (e) {
    print("Error fetching missing person data: $e");
    return [];
  }
}
