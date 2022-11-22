import 'package:flutter/material.dart';
import 'package:flutter_map_training/common/routes.dart';
import 'package:flutter_map_training/common/utils/logger.dart';

void main() async {
  setupLogger();
  runApp(const Test());
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stations App',
      initialRoute: stationsScreenRoute,
      routes: appRoutes,
    );
  }
}