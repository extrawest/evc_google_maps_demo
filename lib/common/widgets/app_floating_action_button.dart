import 'package:flutter/material.dart';

class AppFloatingActionButton extends StatelessWidget {
  const AppFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      width: 68,
      child: FittedBox(
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          child: const Icon(Icons.electric_bolt_rounded,color: Colors.grey),
          onPressed: () {},
        ),
      ),
    );
  }
}
