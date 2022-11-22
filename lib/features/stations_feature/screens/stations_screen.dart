import 'package:flutter/material.dart';
import 'package:flutter_map_training/common/widgets/app_bottom_bar.dart';
import 'package:flutter_map_training/common/widgets/app_floating_action_button.dart';
import 'package:flutter_map_training/features/stations_feature/widgets/side_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widgets/search_bar.dart';

class StationsScreen extends StatelessWidget {
  const StationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GoogleMap(
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(50.467256, 30.513036),
              zoom: 16,
            ),
          ),
          const SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SearchBar(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 16,
                bottom: 16,
                left: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  SideButton(icon: Icons.my_location),
                  SizedBox(height: 8),
                  SideButton(icon: Icons.menu),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const AppFloatingActionButton(),
      bottomNavigationBar: const ApplicationBottomBar(),
    );
  }
}
