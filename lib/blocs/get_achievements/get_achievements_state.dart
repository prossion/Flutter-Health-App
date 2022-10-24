import 'package:equatable/equatable.dart';
import 'package:flutter_health/models/achievement_model.dart';

class GetAchievemntsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetAchievemntsInitialState extends GetAchievemntsState {
  @override
  List<Object?> get props => [];
}

class GetAchievemntsLoadingState extends GetAchievemntsState {
  @override
  List<Object?> get props => [];
}

class GetAchievemntsLoadedState extends GetAchievemntsState {
  final List<Achievement> achievemnt;

  GetAchievemntsLoadedState({required this.achievemnt});
  @override
  List<Object?> get props => [achievemnt];
}

class GetAchievemntsErrorState extends GetAchievemntsState {
  @override
  List<Object?> get props => [];
}
