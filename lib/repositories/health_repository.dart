import 'package:flutter_health/services/health_services.dart';
import 'package:health/health.dart';

class HealthRepository {
  final HealthServices services;

  HealthRepository({required this.services});

  Future<Map<String, int>> fetchHealthData() => services.fetchHealthData();
}
