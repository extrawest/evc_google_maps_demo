
import 'package:flutter/material.dart';
import 'package:flutter_map_training/features/stations_feature/screens/stations_screen.dart';

const String stationsScreenRoute = '/stations_screen';


Map<String, WidgetBuilder> appRoutes = {
  stationsScreenRoute: (context) => const StationsScreen(),
};