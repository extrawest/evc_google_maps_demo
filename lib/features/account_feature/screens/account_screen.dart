import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_training/features/account_feature/bloc/account_bloc.dart';
import 'package:flutter_map_training/features/account_feature/screens/signin_screen.dart';
import 'package:flutter_map_training/features/account_feature/screens/signout_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accountBloc = context.watch<AccountBloc>();
    return accountBloc.state.userCredential == null
        ? const SignInScreen()
        : const SignOutScreen();
  }
}
