import 'package:flutter_map_training/common/ui/screens/home_screen/home_state.dart';

abstract class HomeEvent {}

class SwitchTabEvent extends HomeEvent {
  final AppScreen currentScreen;

  SwitchTabEvent(this.currentScreen);
}