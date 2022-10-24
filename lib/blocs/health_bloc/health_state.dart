import 'package:equatable/equatable.dart';
import 'package:health/health.dart';

class HealthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HealthInitialState extends HealthState {
  @override
  List<Object?> get props => [];
}

class HealthLoadingState extends HealthState {
  @override
  List<Object?> get props => [];
}

class HealthLoadedState extends HealthState {
  final int totalSteps;
  final int totalCalories;
  HealthLoadedState({required this.totalSteps, required this.totalCalories});
  @override
  List<Object?> get props => [totalSteps, totalCalories];
}

class HealthErrorState extends HealthState {
  @override
  List<Object?> get props => [];
}
