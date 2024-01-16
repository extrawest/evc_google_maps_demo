import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_training/common/theme.dart';
import 'package:flutter_map_training/features/stations_feature/bloc/bloc.dart';

class SearchBarWidget extends StatelessWidget {
  final bool autofocus;

  const SearchBarWidget({
    this.autofocus = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          kIsWeb || Platform.isAndroid ? const EdgeInsets.only(top: 16) : null,
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: greyWhite),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          const Icon(Icons.search),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              autofocus: autofocus,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Type here',
              ),
              style: const TextStyle(fontSize: 18),
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                context.read<StationsBloc>().add(SearchQueryChangedEvent(value));
              },
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.cancel_outlined)),
        ],
      ),
    );
  }
}
