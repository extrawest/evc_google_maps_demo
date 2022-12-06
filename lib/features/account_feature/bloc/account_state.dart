import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountState extends Equatable {
  final UserCredential? userCredential;

  const AccountState({
    this.userCredential,
  });

  AccountState copyWith({
    UserCredential? userCredential,
    bool isSignedOut = false,
  }) {
    return AccountState(
      userCredential: isSignedOut ? null : userCredential ?? this.userCredential,
    );
  }

  @override
  List<Object?> get props => [
        userCredential,
      ];
}
