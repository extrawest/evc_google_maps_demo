import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../repository/station_repository.dart';
import 'bloc.dart';

class StationsBloc extends Bloc<StationsEvent, StationsState> {
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
    if(event.stations.length == 1) {
      final station = event.stations.first;
      print(station.status);
    }
    emit(state.copyWith(
      zoomLevel: state.zoomLevel + 1,
    ));
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
}
