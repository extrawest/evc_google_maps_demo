import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_training/features/stations_feature/widgets/selected_station_modal.dart';
import 'package:flutter_map_training/features/stations_feature/widgets/side_button.dart';
import 'package:flutter_map_training/features/stations_feature/widgets/stations_bottom_sheet.dart';
import '../bloc/bloc.dart';

class MapUtilityButtons extends StatelessWidget {
  const MapUtilityButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedStation = context.watch<StationsBloc>().state.selectedStation;
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SideButton(
              icon: Icons.my_location,
              onPressed: () async {
                context.read<StationsBloc>().add(LocationRequestedEvent(
                  onLocationDenied: () {
                    final scaffold = ScaffoldMessenger.of(context);
                    scaffold.hideCurrentSnackBar();
                    scaffold.showSnackBar(_buildSnackBar(context));
                  },
                ));
              },
            ),
            const SizedBox(height: 8),
            SideButton(
              icon: Icons.layers_outlined,
              onPressed: () {
                _showBottomSheet(context);
              },
            ),
            if (selectedStation != null)
              SelectedStationModal(
                station: selectedStation,
              ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  SnackBar _buildSnackBar(BuildContext context) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          const Icon(Icons.error),
          const SizedBox(width: 8),
          const Text('Location denied'),
          const Spacer(),
          if (kIsWeb)
            const Text('Location is denied.')
          else
            TextButton(
              onPressed: () {
                context.read<StationsBloc>().add(PermissionRequestEvent());
              },
              child: const Text('Open Settings'),
            ),
          TextButton(
            onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
            child: const Text('Close'),
          ),
        ],
      ),
      duration: const Duration(seconds: 5),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      context: context,
      builder: (_) => StationsBottomSheet(
        onStationTypeSelected: (type) {
          context.read<StationsBloc>().add(ChangeMapTypeEvent(type));
        },
        currentMapType: context.read<StationsBloc>().state.mapType,
      ),
    );
  }
}
