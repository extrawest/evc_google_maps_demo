import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_training/features/stations_feature/widgets/map_utility_buttons.dart';
import 'package:flutter_map_training/features/stations_feature/widgets/stations_map.dart';
import '../bloc/bloc.dart';
import '../widgets/search_bar.dart';

class StationsScreen extends StatelessWidget {
  const StationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<StationsBloc, StationsState>(
          builder: (context, state) {
            switch (state.status) {
              case StationStatus.initial:
              case StationStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case StationStatus.loaded:
                return StationsMap(stations: state.stations);
              case StationStatus.error:
                return const Center(child: Text('failed to fetch stations'));
            }
          },
        ),
        const SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: SearchBar(),
            ),
          ),
        ),
        const MapUtilityButtons(),
      ],
    );
  }
}
