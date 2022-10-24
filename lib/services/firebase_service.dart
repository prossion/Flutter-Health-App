import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_health/models/achievement_model.dart';

class FirebaseService {
  Stream<List<Achievement>> getAchievements() {
    final data = FirebaseFirestore.instance.collection('achievements');
    return data.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => Achievement.fromSnapshot(e)).toList());
  }

  Future<void> updateDataFirestore(String collectionPath, String docPath,
      Map<String, dynamic> dataNeedUpdate) {
    return FirebaseFirestore.instance
        .collection(collectionPath)
        .doc(docPath)
        .update(dataNeedUpdate);
  }
}
