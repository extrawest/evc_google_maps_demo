import 'package:flutter/material.dart';
import 'package:flutter_map_training/features/wallet_feature/model/transaction_item.dart';
import 'package:intl/intl.dart';

class TransactionListItem extends StatelessWidget {
  final TransactionItem transaction;

  const TransactionListItem({
    required this.transaction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeSpent = _calculateTimeSpent(
      transaction.datetimeStarted,
      transaction.datetimeFinished,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.stationName.split('-').first,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${transaction.consumedKwh.toStringAsFixed(2)} kWh | $timeSpent ',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              )
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat('d MMMM yyyy, h:mm')
                    .format(DateTime.parse(transaction.datetimeStarted)),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '-\$${transaction.bill.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _calculateTimeSpent(String datetimeStarted, String datetimeEnded) {
    final started = DateTime.parse(datetimeStarted);
    final ended = DateTime.parse(datetimeEnded);
    final difference =  ended.difference(started);
    return '${difference.inHours}h ${difference.inMinutes % 60}m';
  }
}
