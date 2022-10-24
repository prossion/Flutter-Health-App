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
  final List<HealthDataPoint> points;
  HealthLoadedState({required this.points});
  @override
  List<Object?> get props => [points];
}

class HealthErrorState extends HealthState {
  @override
  List<Object?> get props => [];
}
