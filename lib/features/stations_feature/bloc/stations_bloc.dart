import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../common/utils/logger.dart';
import '../models/station_model.dart';
import '../repository/station_repository.dart';
import 'bloc.dart';

class StationsBloc extends Bloc<StationsEvent, StationsState> {
  final _levels = const [1.0, 4.25, 6.75, 8.25, 11.5, 14.5, 16.0, 16.5];

  final StationRepository stationsRepository;
  GoogleMapController? mapController;

  StationsBloc(this.stationsRepository) : super(const StationsState()) {
    on<FetchStationsEvent>(_onStationsFetched);
    on<StationClusterTappedEvent>(_onStationTapped);
    on<ChangeMapTypeEvent>(_onMapTypeChanged);
    on<LocationRequestedEvent>(_onLocationRequested);
    on<PermissionRequestEvent>(_onPermissionRequested);
    on<AddFavoriteEvent>(_onAddFavorite);
    on<RemoveSelectedStationEvent>(_onRemoveSelectedStation);
    on<SearchQueryChangedEvent>(_onSearchQueryChanged);
    on<AddToRecentSearchesEvent>(_onAddToRecentSearches);
    on<ClearSearchQueryEvent>(_onClearSearchQuery);
    on<StationSelectedViaSearchEvent>(_onStationSelectedViaSearch);
    on<OnCameraMoveEvent>(_onCameraMove);
  }

  void initMapController(GoogleMapController controller) {
    mapController = controller;
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
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: event.cluster.location,
          zoom: _levels.last,
        ),
      ));
      final station = stationCluster.first;
      emit(state.copyWith(selectedStation: station));
    } else {
      final zoomLevel = await mapController?.getZoomLevel();
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: event.cluster.location,
          zoom: _getNextLevel(zoomLevel!, _levels),
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
      mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: location,
          zoom: 10,
        ),
      ));
    } catch (error) {
      event.onLocationDenied();
      log.severe(error);
    }
  }

  Future<void> _onAddFavorite(
    AddFavoriteEvent event,
    Emitter<StationsState> emit,
  ) async {
    final favorites = [...state.favorites];
    if (favorites.contains(event.station)) {
      favorites.remove(event.station);
    } else {
      favorites.add(event.station);
    }
    emit(state.copyWith(favorites: favorites));
  }

  Future<void> _onPermissionRequested(
    PermissionRequestEvent event,
    Emitter<StationsState> emit,
  ) async {
    await stationsRepository.requestPermission();
  }

  Future<void> _onRemoveSelectedStation(
    RemoveSelectedStationEvent event,
    Emitter<StationsState> emit,
  ) async {
    if (state.selectedStation != null) {
      emit(state.copyWith(selectedStation: null, clearSelectedStation: true));
    }
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChangedEvent event,
    Emitter<StationsState> emit,
  ) async {
    emit(state.copyWith(searchQuery: event.searchQuery));
  }

  Future<void> _onAddToRecentSearches(
    AddToRecentSearchesEvent event,
    Emitter<StationsState> emit,
  ) async {
    final recentSearches = [...state.recentSearches];
    if (recentSearches.contains(event.station)) {
      return;
    }
    else {
      recentSearches.add(event.station);
    }
    emit(state.copyWith(recentSearches: recentSearches));
  }

  Future<void> _onClearSearchQuery(
    ClearSearchQueryEvent event,
    Emitter<StationsState> emit,
  ) async {
    emit(state.copyWith(searchQuery: ''));
  }

  Future<void> _onStationSelectedViaSearch(
    StationSelectedViaSearchEvent event,
    Emitter<StationsState> emit,
  ) async {
    mapController?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: event.station.location,
        zoom: 16,
      ),
    ));
    emit(state.copyWith(selectedStation: event.station));
  }

  Future<void> _onCameraMove(
    OnCameraMoveEvent event,
    Emitter<StationsState> emit,
  ) async {
    emit(state.copyWith(cameraPosition: event.cameraPosition));
  }

  bool isFavorite(Station station) {
    return state.favorites.contains(station);
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
