import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/station_model.dart';
import '../repository/station_repository.dart';
import 'bloc.dart';

class StationsBloc extends Bloc<StationsEvent, StationsState> {
  final _levels = const [1.0, 4.25, 6.75, 8.25, 11.5, 14.5, 16.0, 16.5];

  final StationRepository stationsRepository;
  final Completer<GoogleMapController> mapController = Completer();

  StationsBloc(this.stationsRepository) : super(const StationsState()) {
    on<FetchStationsEvent>(_onStationsFetched);
    on<StationClusterTappedEvent>(_onStationTapped);
    on<ChangeMapTypeEvent>(_onMapTypeChanged);
    on<LocationRequestedEvent>(_onLocationRequested);
    on<PermissionRequestEvent>(_onPermissionRequested);
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
    final Iterable<Station> stationCluster =
        event.cluster.items.cast<Station>();
    if (stationCluster.length == 1) {
      final controller = await mapController.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: event.cluster.location,
          zoom: _levels.last,
        ),
      ));
      final station = stationCluster.first;
      print(station.status);
    } else {
      final controller = await mapController.future;
      final zoomLevel = await controller.getZoomLevel();
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: event.cluster.location,
          zoom: _getNextLevel(zoomLevel, _levels),
        ),
      ));
    }
  }

  Future<void> _onMapTypeChanged(
    ChangeMapTypeEvent event,
    Emitter<StationsState> emit,
  ) async {
    emit(state.copyWith(
      mapType: event.mapType,
    ));
  }

  Future<void> _onLocationRequested(
    LocationRequestedEvent event,
    Emitter<StationsState> emit,
  ) async {
    try {
      final location = await stationsRepository.getCurrentLocation();
      final controller = await mapController.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: location,
          zoom: 10,
        ),
      ));
    } catch (_) {
      event.onLocationDenied();
    }
  }

  Future<void> _onPermissionRequested(
    PermissionRequestEvent event,
    Emitter<StationsState> emit,
  ) async {
    await stationsRepository.requestPermission();
  }

  double _getNextLevel(double value, List<double> levels) {
    double result = 0.0;
    final index = levels.indexOf(
        levels.firstWhere((val) => val > value, orElse: () => levels.last));
    if (index == levels.length - 1) {
      result = levels[index];
    } else {
      result = levels[index];
    }
    return result;
  }
}
