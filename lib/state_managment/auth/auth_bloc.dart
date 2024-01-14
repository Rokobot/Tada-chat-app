import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tada/components/methods/methods.dart';
import 'package:tada/extentions/extentions.dart';
import 'package:tada/services/AuthService.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthSignUpEvent>(SignUpMethod);
    on<AuthSignInEvent>(SignInMethod);
  }

  void SignUpMethod(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    //Emitter to load
    emit(AuthLoadingState());
    await AuthService().signUpWithEmailAndPassword(email: event.email, password: event.password,userName: event.userName).then((value){
      if(value[0]){
        emit(AuthSuccesState());
        //Onboarding or HomePage
        /*
        if(OnboardingShow == true ? Onboarding : HomePage)
         */
        nextScreen(event.context, '/OnboardingPage');
      }else{
        emit(AuthSuccesState());
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(value[1].toString()) ));
      }
    });

  }

  void SignInMethod(AuthSignInEvent event, Emitter<AuthState> emit) async {
    //Emitter to laod
    emit(AuthLoadingState());
    await AuthService().signInWithEmailAndPassword(email: event.email, passwrod: event.password).then((value){
      if(value[0]){
        emit(AuthSuccesState());
        nextScreen(event.context, '/HomePage');
      }else{
        emit(AuthSuccesState());
        ScaffoldMessenger.of(event.context).showSnackBar(SnackBar(content: Text(value[1].toString())));
      }
    });



  }
}
