
import 'package:firebase_auth/firebase_auth.dart';

import '../services/signup_service.dart';

abstract class AccountRepository {
  final SignInService signInService;

  const AccountRepository({
    required this.signInService,
  });

  Future<UserCredential> signIn();
  Future<void> logOut();
}

class AccountRepositoryImpl implements AccountRepository {
  @override
  final SignInService signInService;

  AccountRepositoryImpl(this.signInService);

  @override
  Future<UserCredential> signIn() async {
    return await signInService.signIn();
  }

  @override
  Future<void> logOut() async {
    await signInService.logOut();
  }
}