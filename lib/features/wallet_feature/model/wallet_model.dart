import 'package:equatable/equatable.dart';
import 'package:flutter_map_training/features/wallet_feature/model/transaction_item.dart';

class Wallet {
  final double balance;
  final List<TransactionItem> transactions;

  const Wallet({required this.balance, required this.transactions});


  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      balance: json['balance'] as double,
      transactions: json['history']
          .map<TransactionItem>((e) => TransactionItem.fromJson(e))
          .toList(),
    );
  }
}