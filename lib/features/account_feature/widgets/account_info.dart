import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_training/features/account_feature/widgets/account_info_field.dart';

import '../bloc/account_bloc.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accountBloc = context.watch<AccountBloc>();
    final photoUrl = accountBloc.state.userCredential?.user?.photoURL;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (photoUrl != null)
          CircleAvatar(
            backgroundImage: NetworkImage(photoUrl),
            radius: 60,
          )
        else
          const SizedBox(),
        const SizedBox(height: 16),
        AccountInfoFiled(
          label: 'Name',
          icon: Icons.person,
          value: accountBloc.state.userCredential?.user?.displayName ?? '',
        ),
        const SizedBox(height: 16),
        AccountInfoFiled(
          label: 'Email',
          icon: Icons.email,
          value: accountBloc.state.userCredential?.user?.email ?? '',
        )
      ],
    );
  }
}
