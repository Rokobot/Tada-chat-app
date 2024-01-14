import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tada/firebase_options.dart';
import 'package:tada/pages/auth/signin_page.dart';
import 'package:tada/pages/auth/signup_page.dart';
import 'package:tada/pages/home_page.dart';
import 'package:tada/pages/initial_page.dart';
import 'package:tada/pages/onboarding/onboarding.dart';
import 'package:tada/state_managment/auth/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthBloc(),
      child: MaterialApp(
        routes: {
          '/HomePage': (context) => HomePage(),
          '/SignInPage': (context) => SignInPage(),
          '/SignUpPage': (context) => SignUpPage(),
          '/OnboardingPage': (context) => OnboardingPage()
        },
        home: Scaffold(
          body: InitialPage(),
        ),
      ),
    );
  }
}
