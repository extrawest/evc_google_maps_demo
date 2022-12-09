import 'package:flutter/material.dart';

import '../../routes.dart';

class AppFloatingActionButton extends StatelessWidget {
  const AppFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(0, -3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(3),
      height: 68,
      width: 68,
      child: FittedBox(
        child: FloatingActionButton(
          elevation: 0,
          shape: const CircleBorder(),
          backgroundColor: Colors.white,
          child: const Icon(Icons.electric_bolt_rounded,color: Colors.grey),
          onPressed: () {
            Navigator.of(context).pushNamed(chargingScreenRoute);
          },
        ),
      ),
    );
  }
}
