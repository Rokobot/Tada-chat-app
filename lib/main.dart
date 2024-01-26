import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tada/firebase_options.dart';
import 'package:tada/helper/helper_function.dart';
import 'package:tada/pages/auth/signin_page.dart';
import 'package:tada/pages/auth/signup_page.dart';
import 'package:tada/pages/chat/chat_paga.dart';
import 'package:tada/pages/home_page.dart';
import 'package:tada/pages/initial_page.dart';
import 'package:tada/pages/onboarding/onboarding.dart';
import 'package:tada/pages/settings_page.dart';
import 'package:tada/state_managment/auth/auth_bloc.dart';
import 'package:tada/state_managment/searched_story/searched_story_bloc.dart';
import 'package:tada/state_managment/theme/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool valueTheme = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTheme();
  }

  initTheme() async {
    valueTheme = await HelperFunction().getThemeMode() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AuthBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => SearchedStoryBloc(),
        )
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext context, ThemeState state) {
          if (state is CurrentThemeState) {
            bool valueTheme = state.themeIs;
            return buildMaterialApp(valueTheme);
          }
          return buildMaterialApp(valueTheme);
        },
      ),
    );
  }

  MaterialApp buildMaterialApp(bool valueTheme) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: valueTheme ? ThemeData.dark() : ThemeData.light(),
      routes: {
        '/HomePage': (context) => HomePage(),
        '/SignInPage': (context) => SignInPage(),
        '/SignUpPage': (context) => SignUpPage(),
        '/OnboardingPage': (context) => OnboardingPage(),
        '/Settings': (context) => SettingsPage(),
      },
      home: Scaffold(
        body: InitialPage(),
      ),
    );
  }
}
