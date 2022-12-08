import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/station_model.dart';

enum StationStatus { initial, loading, loaded, error }

class StationsState extends Equatable {
  final StationStatus status;
  final List<Station> stations;
  final MapType mapType;
  final CameraPosition cameraPosition;
  final List<Station> favorites;
  final Station? selectedStation;
  final String searchQuery;
  final List<Station> recentSearches;

  const StationsState({
    this.status = StationStatus.initial,
    this.stations = const <Station>[],
    this.mapType = MapType.normal,
    this.cameraPosition = const CameraPosition(
      target: LatLng(47.808376, 14.373285),
      zoom: 8,
    ),
    this.favorites = const <Station>[],
    this.selectedStation,
    this.searchQuery = '',
    this.recentSearches = const <Station>[],
  });

  StationsState copyWith({
    StationStatus? status,
    List<Station>? stations,
    MapType? mapType,
    CameraPosition? cameraPosition,
    List<Station>? favorites,
    Station? selectedStation,
    bool clearSelectedStation = false,
    String? searchQuery,
    List<Station>? recentSearches,
  }) {
    return StationsState(
      status: status ?? this.status,
      stations: stations ?? this.stations,
      mapType: mapType ?? this.mapType,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      favorites: favorites ?? this.favorites,
      selectedStation:
          clearSelectedStation ? null : selectedStation ?? this.selectedStation,
      searchQuery: searchQuery ?? this.searchQuery,
      recentSearches: recentSearches ?? this.recentSearches,
    );
  }

  @override
  List<Object?> get props => [
        status,
        stations,
        mapType,
        cameraPosition,
        favorites,
        selectedStation,
        searchQuery,
        recentSearches,
      ];
}
