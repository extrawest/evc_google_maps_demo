
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Station with ClusterItem {
  final String stationId;
  final String tenatId;
  final String chargePointId;
  final double longitude;
  final double latitude;
  final String status;

  Station({
    required this.stationId,
    required this.tenatId,
    required this.chargePointId,
    required this.longitude,
    required this.latitude,
    required this.status,
  });

factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      stationId: json['stationId'] as String,
      tenatId: json['tenatId'] ?? '',
      chargePointId: json['chargePointId'] as String,
      longitude: json['longitude'] as double,
      latitude: json['latitude'] as double,
      status: json['status'] ?? 'null',
    );
  }

  @override
  LatLng get location => LatLng(latitude, longitude);
}