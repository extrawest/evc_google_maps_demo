import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/station_model.dart';

abstract class StationsEvent extends Equatable {
  const StationsEvent();
  @override
  List<Object> get props => [];
}

class FetchStationsEvent extends StationsEvent {}

class StationClusterTappedEvent extends StationsEvent {
  final Iterable<Station> stations;
  const StationClusterTappedEvent(this.stations);
}

class ChangeMapTypeEvent extends StationsEvent {
  final MapType mapType;
  const ChangeMapTypeEvent(this.mapType);
}