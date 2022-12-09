import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_training/common/utils/assets.dart';
import 'package:flutter_map_training/features/account_feature/bloc/bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Sign Up',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: Colors.grey,
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            onPressed: () {
              context.read<AccountBloc>().add(SignInEvent());
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(googleLogoAsset ,height: 24,),
                  const SizedBox(width: 20),
                  const Text('Sign Up with Google', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          ),
          const SizedBox(),
        ],
      ),
    );
  }
}
