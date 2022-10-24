import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_health/blocs/health_bloc/health_bloc.dart';
import 'package:flutter_health/blocs/health_bloc/health_event.dart';
import 'package:flutter_health/blocs/health_bloc/health_state.dart';
import 'package:flutter_health/widgets/health_widget.dart';
import 'package:health/health.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({Key? key}) : super(key: key);

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  @override
  void initState() {
    BlocProvider.of<HealthBloc>(context).add(HealthGetDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HealthBloc, HealthState>(
        builder: (context, state) {
          if (state is HealthLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HealthLoadedState) {
            return HealthWidget(
              steps: state.totalSteps,
              calories: state.totalCalories,
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
