import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_training/common/routes.dart';
import 'package:flutter_map_training/features/stations_feature/widgets/map_utility_buttons.dart';
import 'package:flutter_map_training/features/stations_feature/widgets/search_bar.dart';
import 'package:flutter_map_training/features/stations_feature/widgets/stations_map.dart';
import '../bloc/bloc.dart';
import '../models/station_model.dart';

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
        SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () async {
                  final station =
                      await Navigator.of(context).pushNamed(searchScreenRoute);
                  final stationBloc = context.read<StationsBloc>();
                  stationBloc.add(ClearSearchQueryEvent());
                  if (station != null) {
                    final stationModel = station as Station;
                    stationBloc.add(StationSelectedViaSearchEvent(stationModel));
                  }
                },
                child: const AbsorbPointer(
                  child: Hero(
                    tag: 'SearchBar',
                    child: Material(
                      color: Colors.transparent,
                      child: SearchBarWidget(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const MapUtilityButtons(),
      ],
    );
  }
}
