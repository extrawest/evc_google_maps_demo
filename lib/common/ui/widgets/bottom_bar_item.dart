import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class BottomBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isSelected;

  const BottomBarItem({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            icon,
            color: isSelected ? Colors.black : Colors.grey,
            size: isSelected ? 30 : 24,
          ),
          onPressed: onPressed,
        ),
        Text(
          label,
          style: TextStyle(color: isSelected ? Colors.black : Colors.grey),
        ),
        if (kIsWeb || Platform.isAndroid) const SizedBox(height: 8),
      ],
    );
  }
}
