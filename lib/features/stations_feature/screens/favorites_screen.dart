import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/stations_bloc.dart';
import '../widgets/selected_station_modal.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stationBloc = context.watch<StationsBloc>();
    return Center(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              const Text(
                'Favorites',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              if (stationBloc.state.favorites.isEmpty)
                const Text('No favorites yet')
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: stationBloc.state.favorites.length,
                    itemBuilder: (context, index) {
                      final station = stationBloc.state.favorites[index];
                      return SelectedStationModal(
                        station: station,
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
