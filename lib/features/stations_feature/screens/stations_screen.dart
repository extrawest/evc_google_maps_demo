import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_training/common/ui/screens/home_screen/home_bloc.dart';
import 'package:flutter_map_training/common/ui/widgets/app_bottom_bar.dart';
import 'package:flutter_map_training/common/ui/widgets/app_floating_action_button.dart';
import 'package:flutter_map_training/features/stations_feature/repository/station_repository.dart';
import 'package:flutter_map_training/features/stations_feature/widgets/side_button.dart';
import 'package:flutter_map_training/features/stations_feature/widgets/stations_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../common/ui/screens/home_screen/home_state.dart';
import '../bloc/bloc.dart';
import '../widgets/search_bar.dart';
import '../widgets/stations_bottom_sheet.dart';

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
              children: [
                SideButton(
                  icon: Icons.my_location,
                  onPressed: () async {
                    final stationsBloc = context.read<StationsBloc>();
                    stationsBloc
                        .add(LocationRequestedEvent(onLocationDenied: () {
                      final scaffold = ScaffoldMessenger.of(context);
                      scaffold.hideCurrentSnackBar();
                      scaffold.showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          content: Row(
                            children: [
                              const Icon(Icons.error),
                              const SizedBox(width: 8),
                              const Text('Location denied'),
                              const Spacer(),
                              if (kIsWeb) const Text(
                                  'Location is denied.') else
                                TextButton(
                                  onPressed: () {
                                    stationsBloc.add(PermissionRequestEvent());
                                  },
                                  child: const Text('Open Settings'),
                                ),
                            TextButton(
                              onPressed: scaffold.hideCurrentSnackBar,
                              child: const Text('Close'),
                            ),
                            ],
                          ),
                          duration: const Duration(seconds: 5),
                        ),
                      );
                    }));
                  },
                ),
                const SizedBox(height: 8),
                SideButton(
                  icon: Icons.layers_outlined,
                  onPressed: () {
                    showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      context: context,
                      builder: (_) =>
                          StationsBottomSheet(
                              onStationTypeSelected: (type) {
                                context
                                    .read<StationsBloc>()
                                    .add(ChangeMapTypeEvent(type));
                              },
                              currentMapType:
                              context
                                  .read<StationsBloc>()
                                  .state
                                  .mapType),
                    );
                  },
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
