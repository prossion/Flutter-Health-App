import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_health/blocs/health_bloc/health_event.dart';
import 'package:flutter_health/blocs/health_bloc/health_state.dart';
import 'package:flutter_health/repositories/health_repository.dart';

class HealthBloc extends Bloc<HealthEvent, HealthState> {
  final HealthRepository healthRepository;

  HealthBloc({required this.healthRepository}) : super(HealthInitialState()) {
    on<HealthGetDataEvent>((event, emit) async {
      emit(HealthLoadingState());
      try {
        final points = await healthRepository.fetchHealthData();
        emit(HealthLoadedState(
          totalSteps: points['totalSteps'] ?? 0,
          totalCalories: points['totalCalories'] ?? 0,
        ));
      } catch (e) {
        emit(HealthErrorState());
        rethrow;
      }
    });
  }
}
