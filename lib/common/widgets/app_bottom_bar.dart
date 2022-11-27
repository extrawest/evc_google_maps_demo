import 'dart:io' show Platform;

import 'package:flutter/material.dart';

class ApplicationBottomBar extends StatelessWidget {
  const ApplicationBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 30,
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...iconButtons.map(
            (item) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(item.icon, color: Colors.grey, size: 30,),
                  onPressed: item.onPressed,
                ),
                Text(item.label, style: const TextStyle(color: Colors.grey)),
                if(!Platform.isIOS) const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IconButtonModel {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  IconButtonModel({
    required this.icon,
    required this.label,
    required this.onPressed,
  });
}

final List<IconButtonModel> iconButtons = [
  IconButtonModel(
    icon: Icons.map,
    label: 'MAP',
    onPressed: () {},
  ),
  IconButtonModel(
    icon: Icons.star,
    label: 'FAVORITES',
    onPressed: () {},
  ),
  IconButtonModel(
    icon: Icons.wallet,
    label: 'WALLET',
    onPressed: () {},
  ),
  IconButtonModel(
    icon: Icons.account_circle_rounded,
    label: 'ACCOUNT',
    onPressed: () {},
  ),
];
