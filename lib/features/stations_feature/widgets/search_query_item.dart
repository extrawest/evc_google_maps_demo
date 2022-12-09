import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_training/features/stations_feature/bloc/bloc.dart';

import '../models/station_model.dart';

class SearchQueryItem extends StatelessWidget {
  final Station station;

  const SearchQueryItem(this.station, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  '${station.stationId.split('-').first}...${station.stationId.split('-').last}'),
              const SizedBox(height: 4),
              Text(
                'location: ${station.latitude.toStringAsFixed(3)}, ${station.longitude.toStringAsFixed(3)}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              context.read<StationsBloc>().add(AddToRecentSearchesEvent(station));
              Navigator.of(context).pop(station);
            },
            icon: const Icon(Icons.directions_rounded),
          ),
        ],
      ),
    );
  }
}
