import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_health/blocs/get_achievements/get_achievements_event.dart';
import 'package:flutter_health/blocs/get_achievements/get_achievements_state.dart';
import 'package:flutter_health/repositories/database_repository.dart';

class GetAchievementsBloc
    extends Bloc<GetAchievementsEvent, GetAchievemntsState> {
  final DatabaseRepository databaseRepository;

  GetAchievementsBloc({required this.databaseRepository})
      : super(GetAchievemntsInitialState()) {
    on<GetAchievementsDataEvent>(
      (event, emit) async {
        try {
          emit(GetAchievemntsLoadingState());
          final achievement = databaseRepository.getAchievements();
          await for (final achievemnts in achievement) {
            emit(GetAchievemntsLoadedState(achievemnt: achievemnts));
          }
        } catch (e) {
          emit(GetAchievemntsErrorState());
          rethrow;
        }
      },
    );
    on<UpdateAchievementsEvent>((event, emit) async {
      try {
        await databaseRepository.updateDataFirestore(
            event.collectionPath, event.docPath, event.dataNeedUpdate);
      } catch (e) {
        emit(GetAchievemntsErrorState());
        rethrow;
      }
    });
  }
}
