import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/station_model.dart';

enum StationStatus { initial, loading, loaded, error }

class StationsState extends Equatable {
  final StationStatus status;
  final List<Station> stations;
  final MapType mapType;
  final LatLng location;
  final double zoomLevel;

  const StationsState({
    this.status = StationStatus.initial,
    this.stations = const <Station>[],
    this.mapType = MapType.normal,
    this.location = const LatLng(0, 0),
    this.zoomLevel = 6,
  });

  StationsState copyWith({
    StationStatus? status,
    List<Station>? stations,
    MapType? mapType,
    LatLng? location,
    double? zoomLevel,
    bool? showPopUp,
  }) {
    return StationsState(
      status: status ?? this.status,
      stations: stations ?? this.stations,
      mapType: mapType ?? this.mapType,
      location: location ?? this.location,
      zoomLevel: zoomLevel ?? this.zoomLevel,
    );
  }

  @override
  List<Object> get props => [
        status,
        stations,
        zoomLevel,
        mapType,
        location,
      ];
}
