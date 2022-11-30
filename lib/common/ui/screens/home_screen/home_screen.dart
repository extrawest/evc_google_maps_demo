import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map_training/common/ui/screens/home_screen/home_state.dart';
import 'package:flutter_map_training/features/stations_feature/bloc/bloc.dart';
import 'package:flutter_map_training/features/stations_feature/screens/stations_screen.dart';

import '../../../../features/stations_feature/bloc/stations_bloc.dart';
import '../../../../features/stations_feature/bloc/stations_event.dart';
import '../../../../features/stations_feature/repository/station_repository.dart';
import '../../widgets/app_bottom_bar.dart';
import '../../widgets/app_floating_action_button.dart';
import 'home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
            create: (context) => StationsBloc(
                RepositoryProvider.of<StationRepositoryImpl>(context))
              ..add(FetchStationsEvent()))
      ],
      child: Builder(builder: (context) {
        final homeBloc = context.watch<HomeBloc>();
        return Scaffold(
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              switch (state.currentScreen) {
                case AppScreen.map:
                  return const StationsScreen();
                case AppScreen.favorites:
                  return Container(
                      color: Colors.orange,
                      child: const Center(child: Text('Favorites')));
                case AppScreen.wallet:
                  return const Center(child: Text('Wallet'));
                case AppScreen.account:
                  return const Center(child: Text('Account'));
              }
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: const AppFloatingActionButton(),
          bottomNavigationBar: const ApplicationBottomBar(),
          extendBody: true,
        );
      }),
    );
  }
}
