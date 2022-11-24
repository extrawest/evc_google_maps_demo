import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_training/common/widgets/app_bottom_bar.dart';
import 'package:flutter_map_training/common/widgets/app_floating_action_button.dart';
import 'package:flutter_map_training/features/stations_feature/repository/station_repository.dart';
import 'package:flutter_map_training/features/stations_feature/widgets/side_button.dart';
import 'package:flutter_map_training/features/stations_feature/widgets/stations_map.dart';
import '../bloc/bloc.dart';
import '../widgets/search_bar.dart';

class StationsScreen extends StatelessWidget {
  const StationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          StationsBloc(RepositoryProvider.of<StationRepositoryImpl>(context))
            ..add(FetchStationsEvent()),
      child: Scaffold(
        body: Stack(
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
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 16,
                  bottom: 16,
                  left: 16,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    SideButton(icon: Icons.my_location),
                    SizedBox(height: 8),
                    SideButton(icon: Icons.menu),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: const AppFloatingActionButton(),
        bottomNavigationBar: const ApplicationBottomBar(),
      ),
    );
  }
}
