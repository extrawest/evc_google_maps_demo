import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_training/features/wallet_feature/bloc/bloc.dart';

import '../widgets/wallet_list.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          switch (state.status) {
            case WalletStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case WalletStatus.loaded:
              final wallet = state.wallet;
              if (wallet != null) {
                return WalletList(wallet: wallet);
              }
              else {
                return const Center(child: Text('failed to fetch wallet'));
              }
            case WalletStatus.error:
              return const Center(child: Text('failed to fetch wallet info'));
          }
        }
    );
  }
}
