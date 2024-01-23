import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tada/services/fetchUserFromRepo.dart';
import 'package:tada/services/notfService.dart';
import 'package:tada/services/searchUserFromRepo.dart';
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
  String searchJCode = '';

  //Drawer open
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //Index of search and all user
  int currrentIndex = 1;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Discussion👋🏻'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(Icons.menu),
        ),
        actions: [
          NotfService().notfListShow(context)
        ],
      ),
      drawer: Drawer(
        child: FetchCurrentUserInfo().getCurrentInfo(),
      ),
      body: Scaffold(
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            searchItem('Search...', controllerSearch, (value) {
              setState(() {
                searchJCode = value;
                print(searchJCode);
              });
            }),
            searchJCode == ''
                ? Expanded(
                    flex: 1, child: AllUserFetchData().fetchUserData(context))
                : Expanded(
                    flex: 4,
                    child: SearchUserFromRepo(
                      searchJCode: searchJCode,
                    )),
          ],
        )),
      ),
    );
  }
}
