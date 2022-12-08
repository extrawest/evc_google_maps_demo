import 'package:equatable/equatable.dart';
import 'package:flutter_map_training/features/stations_feature/bloc/bloc.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/station_model.dart';

abstract class StationsEvent extends Equatable {
  const StationsEvent();
  @override
  List<Object> get props => [];
}

class FetchStationsEvent extends StationsEvent {}

class StationClusterTappedEvent extends StationsEvent {
  final Cluster<ClusterItem> cluster;
  const StationClusterTappedEvent({required this.cluster});
}

class ChangeMapTypeEvent extends StationsEvent {
  final MapType mapType;
  const ChangeMapTypeEvent(this.mapType);
}

class LocationRequestedEvent extends StationsEvent {
  final void Function() onLocationDenied;

  const LocationRequestedEvent({required this.onLocationDenied});
}

class PermissionRequestEvent extends StationsEvent {}

class AddFavoriteEvent extends StationsEvent {
  final Station station;
  const AddFavoriteEvent({required this.station});
}

class RemoveSelectedStationEvent extends StationsEvent {}

class SearchQueryChangedEvent extends StationsEvent {
  final String searchQuery;
  const SearchQueryChangedEvent(this.searchQuery);
}

class AddToRecentSearchesEvent extends StationsEvent {
  final Station station;
  const AddToRecentSearchesEvent(this.station);
}

class ClearSearchQueryEvent extends StationsEvent {}

class StationSelectedViaSearchEvent extends StationsEvent {
  final Station station;
  const StationSelectedViaSearchEvent(this.station);
}

class OnCameraMoveEvent extends StationsEvent {
  final CameraPosition cameraPosition;
  const OnCameraMoveEvent(this.cameraPosition);
}