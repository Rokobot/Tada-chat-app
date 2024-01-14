import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tada/components/methods/methods.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkRepo();
  }

  checkRepo() async{
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.authStateChanges().listen((event) {
      print(event);
      if(event != null){
        replaceScreen(context, '/HomePage');
      }else{
        replaceScreen(context, '/SignUpPage');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      ),
    );
  }
}
