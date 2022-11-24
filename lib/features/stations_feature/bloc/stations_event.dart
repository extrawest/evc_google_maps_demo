import 'package:equatable/equatable.dart';

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