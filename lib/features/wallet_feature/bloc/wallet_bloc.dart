import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_training/features/wallet_feature/bloc/bloc.dart';

import '../repository/wallet_repository.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository walletRepository;
  WalletBloc(this.walletRepository) : super(const WalletState()) {
    on<FetchWalletInfo>(_fetchWalletInfo);
  }

  void _fetchWalletInfo(FetchWalletInfo event, Emitter<WalletState> emit) async {
    emit(state.copyWith(status: WalletStatus.loading));
    try {
      final result = await walletRepository.getWalletInfo();
      emit(state.copyWith(status: WalletStatus.loaded, wallet: result));
    }
    catch (e) {
      emit(state.copyWith(status: WalletStatus.error));
    }
  }
}