import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tada/components/const.dart';
import 'package:tada/components/methods/methods.dart';
import 'package:tada/helper/helper_function.dart';
import 'package:tada/services/fetchUserFromRepo.dart';
import 'package:tada/services/searchUserFromRepo.dart';
import 'package:vibration/vibration.dart';
import '../components/variables/components.dart';
import '../services/fetchCurrentUserInfo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Just Test
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  //Search controller && querySnap req
  TextEditingController controllerSearch = TextEditingController();
  String searchName = '';

  //Drawer open
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Discussion👋🏻'),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          _scaffoldKey.currentState?.openDrawer();
        },icon: Icon(Icons.menu),),
      ),
      drawer: Drawer(child: FetchCurrentUserInfo().getCurrentInfo(),),
      body: Scaffold(
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            searchItem('Search...',controllerSearch, (value) {
              setState(() {
                searchName = value;
              });
            }),
            searchName == ''? Container() :  Expanded(flex: 4, child: SearchUserFromRepo(user: searchName,) ),
            Expanded(flex: 2, child: AllUserFetchData().fetchUserData(context))
          ],
        )),
      ),
    );
  }
}

