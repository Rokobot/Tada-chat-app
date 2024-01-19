import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tada/helper/helper_function.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial()) {
    on<ChangeThemeEvent>(changeThemeMethod);
  }

  changeThemeMethod(ChangeThemeEvent event,   Emitter<ThemeState> emit) {
    // TODO: implement event handler
    if(event.themeValue == true){
      HelperFunction().saveThemeMode(false);
      emit(CurrentThemeState(themeIs: false));
    }else{
      HelperFunction().saveThemeMode(true);
      emit(CurrentThemeState(themeIs: true));
    }
  }
}
