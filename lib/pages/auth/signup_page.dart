import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:tada/extentions/extentions.dart';
import 'package:tada/state_managment/auth/auth_bloc.dart';
import 'package:vibration/vibration.dart';
import '../../components/methods/methods.dart';
import '../../components/widgtes/button_widget.dart';
import '../../components/widgtes/text_field_widgte.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirim = TextEditingController();
  TextEditingController controllerUserName = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      //Error handle about signUp
      listener: (BuildContext context, state) {
      },
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state ){
        if(state is AuthInitial){
          return signUp(context);
        }
        if(state is AuthSuccesState){
          return signUp(context);
        }
        if(state is AuthLoadingState){
          return Center(child: CircularProgressIndicator(color: Colors.blue,),);
        }
        return signUp(context);
      }),
    );
  }

  validate(){
    if(_formKey.currentState!.validate()){
      context.read<AuthBloc>().add(AuthSignUpEvent(userName: controllerUserName.text, email: controllerEmail.text, password: controllerPassword.text , context: context,));
    }
  }


  Widget signUp(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
          body: SafeArea(
            child: Stack(children: [
              RiveAnimation.asset('asset/riv/tada_sign_up.riv',fit: BoxFit.cover),
              Center(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0, sigmaY: 100),
                  child: Column(
                    children: [
                      Expanded(child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Create Account', style: TextStyle(color: Colors.white, fontSize: 60),),
                      )),
                      SizedBox(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(70), topRight: Radius.circular(70)),
                              color: Colors.black.withOpacity(0.6),
                        ),
                          child: Form(
                            key:_formKey ,
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                   textFormFieldComponent(
                                        icon: Icons.person,
                                        controller: controllerUserName,
                                        visibleOrInvisible: false,
                                        validate: (value) {
                                          if(!(value.toString().userNameOk())){
                                            Vibration.vibrate(duration: 200);
                                            return 'Enter valid username!';
                                          }
                                        },
                                        hint: 'Username'),
                                    textFormFieldComponent(
                                        icon: Icons.email,
                                        controller: controllerEmail,
                                        visibleOrInvisible: false,
                                        validate: (value) {
                                          if(!(value.toString().emailOk())){
                                            Vibration.vibrate(duration: 200);
                                            return 'Enter valid email!';
                                          }
                                        },
                                        hint: 'Email'),
                                    textFormFieldComponent(
                                        icon: Icons.password,
                                        controller: controllerPassword,
                                        visibleOrInvisible: false,
                                        validate: (value) {
                                          if(!(value.toString().passwordOk())){
                                            Vibration.vibrate(duration: 200);
                                            return 'Enter valid password!';
                                          }
                                        },
                                        hint: 'Password'),
                                    textFormFieldComponent(
                                        icon: Icons.confirmation_number_sharp,
                                        controller: controllerConfirim,
                                        visibleOrInvisible: false,
                                        validate: (value) {
                                          if(!(controllerPassword.text.toString().confirimPassword(value.toString()))){
                                            Vibration.vibrate(duration: 200);
                                            return 'Passwords most be equal!';
                                          }
                                        },
                                        hint: 'Confirim'),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    buttonComponent(func: () {
                                      validate();
                                    }, text: 'Sign up'),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text.rich(TextSpan(text: 'Are you a member?',style: TextStyle(color: Colors.grey), children: [
                                      TextSpan(
                                          text: ' Sign in',
                                          style: TextStyle(color: Colors.blue),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              nextScreenNamed(context,'/SignInPage');
                                            })
                                    ])),
                                    SizedBox(
                                      height: 0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),),
              )
            ],),
          ),
        );
  }
}




