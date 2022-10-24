import 'package:flutter_health/models/achievement_model.dart';
import 'package:flutter_health/services/firebase_service.dart';

class DatabaseRepository {
  final FirebaseService services;

  DatabaseRepository({required this.services});

  Stream<List<Achievement>> getAchievements() => services.getAchievements();

  Future<void> updateDataFirestore(String collectionPath, String docPath,
          Map<String, dynamic> dataNeedUpdate) =>
      services.updateDataFirestore(collectionPath, docPath, dataNeedUpdate);
}
