import 'package:flutter_map_training/features/stations_feature/services/stations_api_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/station_model.dart';
import '../services/location_service.dart';

abstract class StationRepository {
  final StationsApiService stationApiService;
  final LocationService locationService;

  const StationRepository({
    required this.stationApiService,
    required this.locationService,
  });

  Future<List<Station>> getStations();

  Future<LatLng> getCurrentLocation();

  Future<void> requestPermission();
}

class StationRepositoryImpl implements StationRepository {
  @override
  final StationsApiService stationApiService;
  @override
  final LocationService locationService;

  const StationRepositoryImpl({
    required this.stationApiService,
    required this.locationService,
  });

  @override
  Future<List<Station>> getStations() async {
    return await stationApiService.fetchStations();
  }

  @override
  Future<LatLng> getCurrentLocation() async {
    return await locationService.getCurrentLocation();
  }

  @override
  Future<void> requestPermission() async {
    return await locationService.requestPermission();
  }
}
