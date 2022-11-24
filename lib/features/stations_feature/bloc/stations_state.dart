import 'package:equatable/equatable.dart';

import '../models/station_model.dart';

enum StationStatus { initial, loading, loaded, error }

class StationsState extends Equatable {
  final StationStatus status;
  final List<Station> stations;
  final double zoomLevel;

  const StationsState({
    this.status = StationStatus.initial,
    this.stations = const <Station>[],
    this.zoomLevel = 6,
  });

  StationsState copyWith({
    StationStatus? status,
    List<Station>? stations,
    double? zoomLevel,
  }) {
    return StationsState(
      status: status ?? this.status,
      stations: stations ?? this.stations,
      zoomLevel: zoomLevel ?? this.zoomLevel,
    );
  }

  @override
  List<Object> get props => [status, stations, zoomLevel];
}
