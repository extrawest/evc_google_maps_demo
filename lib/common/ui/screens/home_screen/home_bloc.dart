import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<SwitchTabEvent>(_switchTab);
  }

  void _switchTab(SwitchTabEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(currentScreen: event.currentScreen));
  }
}