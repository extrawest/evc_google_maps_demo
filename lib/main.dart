import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_training/common/router.dart';
import 'package:flutter_map_training/common/utils/logger.dart';
import 'package:flutter_map_training/network/api_client.dart';

import 'features/stations_feature/repository/station_repository.dart';
import 'features/stations_feature/services/stations_api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLogger();
  runApp(const RepositoryHolder(child: StationsApp(),));
}

class RepositoryHolder extends StatelessWidget {
  final Widget child;

  const RepositoryHolder({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => StationRepositoryImpl(
            StationsApiServiceImpl(
              ApiClientImpl(apiDomain: 'https://demo1721737.mockable.io/'),
            ),
          ),
        ),
      ],
      child: Builder(builder: (context) => child),
    );
  }
}

class StationsApp extends StatelessWidget {
  const StationsApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
      title: 'Stations App',
    );
  }
}
