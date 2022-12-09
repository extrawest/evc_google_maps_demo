import 'package:flutter/material.dart';

class SideButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const SideButton({
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size.square(48),
      child: Material(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: onPressed,
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
