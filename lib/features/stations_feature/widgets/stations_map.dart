import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final Completer<GoogleMapController> _controller = Completer();
  late ClusterManager _clusterManager;

  Set<Marker> _markers = {};

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(47.808376, 14.373285),
    zoom: 8,
  );

  @override
  void initState() {
    _clusterManager = _initClusterManager();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      mapType: context.read<StationsBloc>().state.mapType,
      initialCameraPosition: _kGooglePlex,
      markers: _markers,
      onCameraMove: _clusterManager.onCameraMove,
      onCameraIdle: _clusterManager.updateMap,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
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
                  .add(StationClusterTappedEvent(stationCluster));
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
        return const Color(0xFFF2C94C);
      case 'available':
        return const Color(0xFF37D858);
      case 'offline':
        return const Color(0xFF222733);
      default:
        return const Color(0xFFEB5757);
    }
  }
}
