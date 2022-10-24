import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_health_app/blocs/health_bloc/health_bloc.dart';
import 'package:flutter_health_app/blocs/health_bloc/health_event.dart';
import 'package:flutter_health_app/blocs/health_bloc/health_state.dart';
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
    List<HealthDataPoint> _healthDataList = [];
    var healthPoint = <HealthDataPoint>[];
    return BlocBuilder<HealthBloc, HealthState>(
      builder: (context, state) {
        if (state is HealthLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HealthLoadedState) {
          _healthDataList = state.points;
        }
        return ListView.builder(itemBuilder: (context, index) {
          HealthDataPoint p = _healthDataList![index];
          return Card(
            child: Text(_healthDataList.toString()),
          );
        });
      },
    );
  }
}
