import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/station_repository.dart';
import 'bloc.dart';

class StationsBloc extends Bloc<StationsEvent, StationsState> {
  final StationRepository stationsRepository;

  StationsBloc(this.stationsRepository) : super(const StationsState()) {
    on<FetchStationsEvent>(_onStationsFetched);
    on<StationClusterTappedEvent>(_onStationTapped);
  }

  Future<void> _onStationsFetched(
    FetchStationsEvent event,
    Emitter<StationsState> emit,
  ) async {
    emit(state.copyWith(status: StationStatus.loading));
    try {
      final stations = await stationsRepository.getStations();
      emit(state.copyWith(
        status: StationStatus.loaded,
        stations: stations,
      ));
    } catch (_) {
      emit(state.copyWith(status: StationStatus.error));
    }
  }

  Future<void> _onStationTapped(
    StationClusterTappedEvent event,
    Emitter<StationsState> emit,
  ) async {
    if(event.stations.length == 1) {
      final station = event.stations.first;
      print(station.status);
    }
    emit(state.copyWith(
      zoomLevel: state.zoomLevel + 1,
    ));
  }
}
