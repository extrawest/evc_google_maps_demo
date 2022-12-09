import 'package:flutter/material.dart';
import 'package:flutter_map_training/common/theme.dart';
import 'package:flutter_map_training/features/wallet_feature/widgets/transaction_list_item.dart';

import '../model/wallet_model.dart';

class WalletList extends StatelessWidget {
  final Wallet wallet;

  const WalletList({Key? key, required this.wallet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: greyWhite,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: greyWhite,
            collapsedHeight: 80,
            expandedHeight: 220,
            flexibleSpace: FlexibleSpaceBar(
              background: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Wallet',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 46),
                  ],
                ),
              ),
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    'Balance',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '\$ ${wallet.balance.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: const Text(
                'History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              final transaction = wallet.transactions[index];
              return TransactionListItem(transaction: transaction);
            },
            childCount: wallet.transactions.length,
          )),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}