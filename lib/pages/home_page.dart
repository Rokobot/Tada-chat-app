import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tada/components/widgtes/button_widget.dart';
import 'package:tada/pages/onboarding/onboarding.dart';




class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Just Test
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HomePage'),centerTitle: true,),
      body: Scaffold(
        body: Center(child: buttonComponent(text: 'sign out', func: () async{
          //Just Test
          await firebaseAuth.signOut();
        }),),
      )
    );
  }
}
