import 'package:equatable/equatable.dart';

class TransactionItem extends Equatable {
  final String datetimeStarted;
  final double bill;
  final String datetimeFinished;
  final String stationName;
  final double consumedKwh;

  const TransactionItem({
    required this.datetimeStarted,
    required this.bill,
    required this.datetimeFinished,
    required this.stationName,
    required this.consumedKwh,
  });

  @override
  List<Object?> get props => [
    datetimeStarted,
    bill,
    datetimeFinished,
    stationName,
    consumedKwh,
  ];

  factory TransactionItem.fromJson(Map<String, dynamic> json) {
    return TransactionItem(
      datetimeStarted: json['datetime_started'] as String,
      bill: json['bill'] as double,
      datetimeFinished: json['datetime_finished'] as String,
      stationName: json['station_name'] as String,
      consumedKwh: json['consumed_kwh'] as double,
    );
  }
}