import 'package:flutter_map_training/features/stations_feature/services/stations_api_service.dart';

import '../models/station_model.dart';

abstract class StationRepository {
  final StationsApiService stationApiService;
  const StationRepository(this.stationApiService);

  Future<List<Station>> getStations();
}

class StationRepositoryImpl implements StationRepository {
  @override
  final StationsApiService stationApiService;

  const StationRepositoryImpl(this.stationApiService);

  @override
  Future<List<Station>> getStations() async {
    return await stationApiService.fetchStations();
  }
}