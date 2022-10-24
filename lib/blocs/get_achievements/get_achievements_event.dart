import 'package:equatable/equatable.dart';

class GetAchievementsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAchievementsDataEvent extends GetAchievementsEvent {
  @override
  List<Object?> get props => [];
}

class UpdateAchievementsEvent extends GetAchievementsEvent {
  final String collectionPath;
  final String docPath;
  final Map<String, dynamic> dataNeedUpdate;

  UpdateAchievementsEvent(
      {required this.collectionPath,
      required this.docPath,
      required this.dataNeedUpdate});
  @override
  List<Object?> get props => [
        collectionPath,
        docPath,
        dataNeedUpdate,
      ];
}
