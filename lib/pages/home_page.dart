import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tada/services/fetchUserFromRepo.dart';

import '../components/variables/components.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //Search controller
  TextEditingController controllerSearch = TextEditingController();


  //Just Test
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                firebaseAuth.signOut();
              },
              icon: Icon(Icons.exit_to_app))
        ],
        title: Text('HomePage'),
        centerTitle: true,
      ),
      body: Scaffold(
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            searchItem('Search...',controllerSearch),
            Expanded(child: AllUserFetchData().fetchUserData())
          ],
        )),
      ),
    );
  }
}
