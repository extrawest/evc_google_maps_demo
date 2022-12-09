import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_training/features/account_feature/bloc/account_event.dart';
import 'package:flutter_map_training/features/account_feature/bloc/account_state.dart';

import '../../../common/utils/logger.dart';
import '../repository/account_repository.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository _accountRepository;

  AccountBloc(this._accountRepository) : super(const AccountState()) {
    on<SignInEvent>(_onSignInEvent);
    on<SignOutEvent>(_onSignOutEvent);
  }

  Future<void> _onSignInEvent(
    SignInEvent event,
    Emitter<AccountState> emit,
  ) async {
    try {
      final user = await _accountRepository.signIn();
      emit(state.copyWith(userCredential: user));
    } catch (e) {
      log.severe(e);
    }
  }

  Future<void> _onSignOutEvent(
    SignOutEvent event,
    Emitter<AccountState> emit,
  ) async {
    try {
      await _accountRepository.logOut();
      emit(state.copyWith(isSignedOut: true));
    } catch (e) {
      log.severe(e);
    }
  }
}
