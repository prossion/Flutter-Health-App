import 'package:health/health.dart';

class HealthServices {
  static HealthFactory health = HealthFactory();

  Future<Map<String, int>> fetchHealthData() async {
    final types = [
      HealthDataType.STEPS,
      HealthDataType.ACTIVE_ENERGY_BURNED,
    ];

    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    final healthDataList = await health.getHealthDataFromTypes(
      midnight,
      now,
      types,
    );

    var totalStepsDouble = 0.0;
    var totalCaloriesDouble = 0.0;

    for (final dataPoint in healthDataList) {
      if (dataPoint.type == HealthDataType.STEPS) {
        // Count as steps
        totalStepsDouble += double.tryParse(dataPoint.value.toString()) ?? 0.0;
      } else if (dataPoint.type == HealthDataType.ACTIVE_ENERGY_BURNED) {
        totalCaloriesDouble +=
            double.tryParse(dataPoint.value.toString()) ?? 0.0;
      }
    }

    final dataMap = {
      'totalSteps': totalStepsDouble.round(),
      'totalCalories': totalCaloriesDouble.round(),
    };
    return dataMap;
  }
}
