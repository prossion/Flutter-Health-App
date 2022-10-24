import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_health/blocs/get_achievements/get_achievements_bloc.dart';
import 'package:flutter_health/blocs/get_achievements/get_achievements_state.dart';
import 'package:flutter_health/models/achievement_model.dart';
import 'package:flutter_health/widgets/achievement_widget.dart';

class AchievmentsScreen extends StatelessWidget {
  const AchievmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAchievementsBloc, GetAchievemntsState>(
      builder: (context, state) {
        List<Achievement> achievements = [];
        if (state is GetAchievemntsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetAchievemntsLoadedState) {
          achievements = state.achievemnt;
          return ListView.builder(
            itemCount: achievements.length,
            itemBuilder: (context, index) {
              return achievements.isEmpty
                  ? const Center(
                      child: Text(
                        'There are not of achievements avialable',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    )
                  : AchievementWidget(achievement: achievements[index]);
            },
          );
        } else if (state is GetAchievemntsErrorState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
