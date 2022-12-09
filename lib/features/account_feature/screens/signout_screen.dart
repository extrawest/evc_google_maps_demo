import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_training/features/account_feature/bloc/account_bloc.dart';

import '../bloc/account_event.dart';
import '../widgets/account_info.dart';

class SignOutScreen extends StatelessWidget {
  const SignOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text('Profile',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const SizedBox(height: 32),
            const AccountInfo(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextButton(
                style: TextButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.black12,
                  foregroundColor: Colors.black54,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                onPressed: () {
                  context.read<AccountBloc>().add(SignOutEvent());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Log Out',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
