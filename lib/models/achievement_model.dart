import 'package:cloud_firestore/cloud_firestore.dart';

class Achievement {
  final String title;
  final String description;
  final String icon;
  final bool completed;

  Achievement(
      {required this.title,
      required this.description,
      required this.icon,
      required this.completed});

  factory Achievement.fromSnapshot(DocumentSnapshot snapshot) {
    return Achievement(
      title: snapshot.data().toString().contains('title')
          ? snapshot.get('title')
          : '',
      description: snapshot.data().toString().contains('description')
          ? snapshot.get('description')
          : '',
      icon: snapshot.data().toString().contains('icon')
          ? snapshot.get('icon')
          : '',
      completed: snapshot.data().toString().contains('completed')
          ? snapshot.get('completed')
          : false,
    );
  }
}
