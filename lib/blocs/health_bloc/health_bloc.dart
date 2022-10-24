import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_health_app/blocs/health_bloc/health_event.dart';
import 'package:flutter_health_app/blocs/health_bloc/health_state.dart';
import 'package:flutter_health_app/repositories/health_repository.dart';

class HealthBloc extends Bloc<HealthEvent, HealthState> {
  final HealthRepository healthRepository;

  HealthBloc({required this.healthRepository}) : super(HealthInitialState()) {
    on<HealthGetDataEvent>((((event, emit) async {
      emit(HealthLoadingState());
      try {
        final points = await healthRepository.fetchHealthData();
        emit(HealthLoadedState(points: points));
      } catch (e) {
        emit(HealthErrorState());
        rethrow;
      }
    })));
  }
}
