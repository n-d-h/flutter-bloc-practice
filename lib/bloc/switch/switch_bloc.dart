import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'switch_event.dart';

part 'switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SharedPreferences? prefs;

  SwitchBloc() : super(const SwitchState()) {
    _init();
    on<InitialSwitchState>(_onInitialSwitchState);
    on<EnableOrDisableNotification>(_onEnableOrDisableNotification);
    on<SliderEvent>(_onSlider);
  }

  void _init() async {
    prefs = await SharedPreferences.getInstance();
    add(InitialSwitchState());
  }

  FutureOr<void> _onInitialSwitchState(
      InitialSwitchState event, Emitter<SwitchState> emit) async {
    bool isSwitchedPref = prefs?.getBool('isSwitched') ?? false;
    emit(state.copyWith(isSwitched: isSwitchedPref));
  }

  FutureOr<void> _onEnableOrDisableNotification(
      EnableOrDisableNotification event, Emitter<SwitchState> emit) async {
    await prefs?.setBool('isSwitched', !state.isSwitched);
    emit(state.copyWith(isSwitched: !state.isSwitched));
  }

  void _onSlider(SliderEvent event, Emitter<SwitchState> emit) {
    emit(state.copyWith(slider: event.slider));
  }
}
