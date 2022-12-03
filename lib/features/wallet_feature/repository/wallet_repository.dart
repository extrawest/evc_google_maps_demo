import '../model/wallet_model.dart';
import '../services/wallet_serivce.dart';

abstract class WalletRepository {
  final WalletService walletService;

  const WalletRepository(this.walletService);

  Future<Wallet> getWalletInfo();
}

class WalletRepositoryImpl implements WalletRepository {
  @override
  final WalletService walletService;

  WalletRepositoryImpl({required this.walletService});

  @override
  Future<Wallet> getWalletInfo() async {
    return walletService.getWalletInfo();
  }
}