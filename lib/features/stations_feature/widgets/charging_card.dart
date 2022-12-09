import 'package:flutter/material.dart';
import 'package:flutter_map_training/common/theme.dart';

import 'charging_proggres_indicator.dart';

class ChargingCard extends StatelessWidget {
  const ChargingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(3, 3),
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(-3, -3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          const ChargingProgressIndicator(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Cost',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '\$ 34.24',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: greyBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: const Text(
                'Stop Charging',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          const SizedBox(height: 34),
          _buildStatisticalItem('Starting Time', '21/07/21 17:46'),
          const SizedBox(height: 16),
          _buildStatisticalItem('Charging Speed', '50 kWh'),
          const SizedBox(height: 16),
          _buildStatisticalItem('Amperage', '15 A'),
          const SizedBox(height: 16),
          _buildStatisticalItem('Voltage', '150 A'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.withOpacity(0.25),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Station Name',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '54466767',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text(
                          'Tariff',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '\$ 3.00 per kWh',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Coordinates',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '54.4567, 54.4567',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: greyWhite,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.ev_station,
                            color: greyBlue,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text('Type 2'),
                          SizedBox(width: 4),
                          Text('AC'),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatisticalItem(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
