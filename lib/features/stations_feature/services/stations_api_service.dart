import '../../../common/utils/logger.dart';
import '../../../network/api_client.dart';
import '../models/station_model.dart';

abstract class StationsApiService {
  final ApiClient _apiClient;

  StationsApiService(this._apiClient);

  Future<List<Station>> fetchStations();
}

class StationsApiServiceImpl implements StationsApiService {
  final String _stationsPath = '/stations.json';

  @override
  final ApiClient _apiClient;

  StationsApiServiceImpl(this._apiClient);

  @override
  Future<List<Station>> fetchStations() async {
    try {
      final stationsListResponse = await _apiClient.get(_stationsPath);
      return stationsListResponse
          .map<Station>((json) => Station.fromJson(json))
          .toList() as List<Station>;
    } catch (e) {
      log.severe('_fetchStations error: $e');
      rethrow;
    }
  }
}
