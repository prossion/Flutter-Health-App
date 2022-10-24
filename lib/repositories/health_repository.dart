import 'package:flutter_health_app/services/health_services.dart';
import 'package:health/health.dart';

class HealthRepository {
  final HealthServices services;

  HealthRepository({required this.services});

  Future<List<HealthDataPoint>> fetchHealthData() => services.fetchHealthData();
}
