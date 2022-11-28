import 'package:flutter_map_training/common/ui/screens/home_screen/home_screen.dart';
import 'package:go_router/go_router.dart';

import '../features/stations_feature/screens/stations_screen.dart';

const String homeScreenPath = '/';
const String loginScreenRoute = '/login_screen';
const String stationsScreenRoute = '/stations_screen';
const String favoritesScreenRoute = '/favorites_screen';
const String walletScreenRoute = '/wallet_screen';
const String accountScreenRoute = '/account_screen';

final goRouter = GoRouter(
  //TODO: replace with google login screen
  initialLocation: homeScreenPath,
  routes: [
    GoRoute(
      path: homeScreenPath,
      builder: (context, state) =>  const HomeScreen(),
    )
  ],
);