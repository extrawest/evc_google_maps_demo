import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_training/common/theme.dart';
import 'package:flutter_map_training/features/stations_feature/bloc/bloc.dart';

import '../models/station_model.dart';

const Map<String, Color> availabilityColors = {
  'busy': busyColor,
  'available': availableColor,
  'offline': offlineColor,
  'null': nullColor,
};

class SelectedStationModal extends StatelessWidget {
  final Station station;

  const SelectedStationModal({
    required this.station,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stationBloc = context.watch<StationsBloc>();
    return Container(
      margin: const EdgeInsets.only(bottom: 24, top: 8),
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: 4,
                  decoration: BoxDecoration(
                    color:
                        availabilityColors[station.status] ?? Colors.red,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      station.chargePointId,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('Status: ${station.status}')
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    stationBloc.add(AddFavoriteEvent(station: station));
                  },
                  icon: Icon(
                    stationBloc.isFavorite(station)
                        ? Icons.star
                        : Icons.star_outline,
                    color: Colors.orange,
                    size: 30,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Coordinates'),
                  Text(
                      '${station.longitude.toStringAsFixed(6)} , ${station.latitude.toStringAsFixed(6)}'),
                ],
              ),
              Spacer(),
              //TODO: replace
              Text('15 m'),
              const SizedBox(width: 8),
              //TODO: replace with direaction logic maybe later
              Icon(Icons.assistant_direction_rounded)
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            color: Colors.black12,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildChargeChip(
                price: 3,
                type: 'Type 2(AC)',
                kWh: 22,
                isAvailable: true,
              ),
              const SizedBox(width: 8),
              _buildChargeChip(
                price: 6,
                type: 'CHAdeMO',
                kWh: 220,
                isAvailable: false,
              ),
              const SizedBox(width: 8),
              _buildChargeChip(
                price: 3,
                type: 'Type 2(AC)',
                kWh: 22,
                isAvailable: false,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChargeChip({
    required double price,
    required String type,
    required int kWh,
    required bool isAvailable,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
              const Icon(Icons.ac_unit_outlined, color: Colors.green),
              const SizedBox(width: 8),
              Text('$price \$',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ]),
            const SizedBox(height: 8),
            Text(type, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('$kWh kWh'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      foregroundColor: Colors.white,
                      backgroundColor: isAvailable ? Colors.green : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: isAvailable ? () {} : null,
                    child: isAvailable ? const Text('Charge') : const Text('In use'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
