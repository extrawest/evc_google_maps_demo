
import 'package:equatable/equatable.dart';
import 'package:flutter_map_training/features/wallet_feature/model/wallet_model.dart';

enum WalletStatus {loading, loaded, error }

class WalletState extends Equatable {
  final WalletStatus status;
  final Wallet? wallet;

  const WalletState({
    this.status = WalletStatus.loading,
    this.wallet,
  });

  WalletState copyWith({
    WalletStatus? status,
    Wallet? wallet,
  }) {
    return WalletState(
      status: status ?? this.status,
      wallet: wallet ?? this.wallet,
    );
  }

  @override
  List<Object?> get props => [status, wallet];
}