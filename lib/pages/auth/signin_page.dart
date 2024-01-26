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

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  @override
  State<SignInPage> createState() => _SignInPageState();
}



class _SignInPageState extends State<SignInPage> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        if(state is AuthInitial){
          return signIn(context);
        }
        if(state is AuthLoadingState){
          return Center(child: CircularProgressIndicator(color: Colors.blue,),);
        }
        if(state is AuthSuccesState){
          return signIn(context);
        }
        return signIn(context);
      },
    );
  }

  validate(){
    if(_formKey.currentState!.validate()){
      context.read<AuthBloc>().add(AuthSignInEvent(email: controllerEmail.text, password: controllerPassword.text, context: context));
    }
  }

  Scaffold signIn(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(children: [
          RiveAnimation.asset('asset/riv/tada_sign_up.riv',fit: BoxFit.cover),
          Center(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 100),
              child: SizedBox(
                child: Card(
                    elevation: 10,
                    color: Colors.black.withOpacity(0.3),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: Text(
                                'Signin',
                                style: TextStyle(fontSize: 30, color: Colors.white),
                              )),
                          textFormFieldComponent(
                              icon: Icons.email,
                              controller: controllerEmail,
                              visibleOrInvisible: false,
                              validate: (value) {
                                if(!(value.toString().emailOk())){
                                  Vibration.vibrate(duration: 200);
                                  return 'Email is wrong!';
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
                                  return 'Passwor is wrong!';
                                }
                              },
                              hint: 'Password'),
                          SizedBox(
                            height: 20,
                          ),
                          buttonComponent(func: () {validate();}, text: 'Signin'),
                          SizedBox(
                            height: 10,
                          ),
                          Text.rich(TextSpan(text: 'Are you a member?',style: TextStyle(color: Colors.grey), children: [
                            TextSpan(
                                text: ' Signin',
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    nextScreenNamed(context,'/SignUpPage');
                                  })
                          ])),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                ),
              ),),
          )
        ],),
      ),
    );
  }
}





