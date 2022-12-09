import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_training/common/theme.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../bloc/bloc.dart';

import '../models/station_model.dart';

class StationsMap extends StatefulWidget {
  final List<Station> stations;

  const StationsMap({
    required this.stations,
    Key? key,
  }) : super(key: key);

  @override
  State<StationsMap> createState() => _StationsMapState();
}

class _StationsMapState extends State<StationsMap> {
  late ClusterManager _clusterManager;

  Set<Marker> _markers = {};

  @override
  void initState() {
    _clusterManager = _initClusterManager();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final stationsBloc = context.read<StationsBloc>();
    return GoogleMap(
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      mapType: stationsBloc.state.mapType,
      initialCameraPosition: stationsBloc.state.cameraPosition,
      markers: _markers,
      onCameraMove: (CameraPosition cameraPosition) {
        stationsBloc.add(OnCameraMoveEvent(cameraPosition));
        _clusterManager.onCameraMove(cameraPosition);
      },
      onCameraIdle: _clusterManager.updateMap,
      onTap: (_) {
        stationsBloc.add(RemoveSelectedStationEvent());
      },
      onMapCreated: (GoogleMapController controller) {
        stationsBloc.initMapController(controller);
        _clusterManager.setMapId(controller.mapId);
      },
    );
  }

  ClusterManager _initClusterManager() => ClusterManager(
        widget.stations,
        _updateMarkers,
        markerBuilder: _markerBuilder,
      );

  void _updateMarkers(Set<Marker> markers) {
    setState(() {
      _markers = markers;
    });
  }

  Future<Marker> Function(Cluster<ClusterItem>)? get _markerBuilder =>
      (Cluster<ClusterItem> cluster) async {
        final Iterable<Station> stationCluster = cluster.items.cast<Station>();
        return Marker(
            markerId: MarkerId(cluster.getId()),
            position: cluster.location,
            onTap: () {
              context
                  .read<StationsBloc>()
                  .add(StationClusterTappedEvent(cluster: cluster));
            },
            icon: await _getMarkerBitmap(
              size: cluster.isMultiple ? 125 : 75,
              color: _getColorFromAvgAvailability(stationCluster),
            ));
      };

  Future<BitmapDescriptor> _getMarkerBitmap({
    required int size,
    required Color color,
  }) async {
    if (kIsWeb) {
      size = (size / 2).floor();
    }
    final PictureRecorder pictureRecorder = PictureRecorder();
    final TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    const icon = Icons.bolt_rounded;
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.white;
    final Paint paint2 = Paint()..color = color;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);
    painter.text = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        fontFamily: icon.fontFamily,
        fontSize: size / 1.5,
        color: color,
      ),
    );
    painter.layout();
    painter.paint(
      canvas,
      Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
    );

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png) as ByteData;

    return BitmapDescriptor.fromBytes(data.buffer.asUint8List());
  }

  Color _getColorFromAvgAvailability(Iterable<Station> items) {
    final Map<String, int> availabilityMap = {
      'busy': 0,
      'available': 0,
      'offline': 0,
      'null': 0,
    };

    for (final station in items) {
      availabilityMap[station.status] = availabilityMap[station.status]! + 1;
    }

    switch (availabilityMap.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key) {
      case 'busy':
        return busyColor;
      case 'available':
        return availableColor;
      case 'offline':
        return offlineColor;
      default:
        return nullColor;
    }
  }
}
