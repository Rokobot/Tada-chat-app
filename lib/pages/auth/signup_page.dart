import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          body: SafeArea(
            child: Center(
              child: Form(
                key:_formKey ,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text(
                          'Signup',
                          style: TextStyle(fontSize: 30),
                        )),textFormFieldComponent(
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
                    }, text: 'Signup'),
                    SizedBox(
                      height: 10,
                    ),
                    Text.rich(TextSpan(text: 'Are you a member?', children: [
                      TextSpan(
                          text: ' Signin',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              nextScreenNamed(context,'/SignInPage');
                            })
                    ]))
                  ],
                ),
              ),
            ),
          ),
        );
  }
}



