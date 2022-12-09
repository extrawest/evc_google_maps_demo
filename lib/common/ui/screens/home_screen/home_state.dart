import 'package:equatable/equatable.dart';

enum AppScreen {
  map,
  favorites,
  wallet,
  account,
}

class HomeState extends Equatable {
  final AppScreen currentScreen;

  const HomeState({
    this.currentScreen = AppScreen.map,
  });

  @override
  List<Object> get props => [currentScreen];

  HomeState copyWith({
    AppScreen? currentScreen,
  }) {
    return HomeState(
      currentScreen: currentScreen ?? this.currentScreen,
    );
  }
}
