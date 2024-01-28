import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:tada/components/const.dart';
import 'package:tada/pages/connect_page.dart';
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

  //Index of search and all user
  int currrentIndex = 1;

  //TapBar controller
   TabController? tabController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: Drawer(
            child: FetchCurrentUserInfo().getCurrentInfo(),
          ),
          body: DefaultTabController(
              length: 2,
              child: NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool scrolled) {
                    return [
                      SliverAppBar(
                        foregroundColor: Colors.white,
                        bottom: TabBar(
                          physics: BouncingScrollPhysics(),
                          indicatorColor: Colors.white,
                          controller: tabController,
                          dividerColor: Colors.transparent,
                          tabs: [
                            Tab(icon: Icon(Icons.person, color: Colors.white,size: 30,)),
                            Tab(icon: Icon(Icons.people_alt_rounded, color: Colors.white,size: 30,)),
                          ],
                        ),
                        actions: [
                          NotfService().notfListShow(context),
                        ],
                        backgroundColor: CusColors().custCosmic,
                        expandedHeight: 250,
                        flexibleSpace: FlexibleSpaceBar(
                            background: Image.asset(
                                'asset/images/cosmonaut.jpg')),
                      )
                    ];

                  },
                  body: TabBarView(
                    physics: BouncingScrollPhysics(),
                    controller: tabController,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5, right: 5, left: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Container(
                                height: 100, child: Align(alignment: Alignment.centerLeft, child: Container(child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text('People', style: TextStyle(fontSize: 25),),
                                ),decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(50)),)),),
                              height: 100,
                            ),
                            searchItem('Search...', controllerSearch, (value) {
                              setState(() {
                                searchJCode = value;
                                print(searchJCode);
                              });
                            }),
                            searchJCode == ''
                                ? Expanded(
                                    flex: 1,
                                    child: AllUserFetchData()
                                        .fetchUserData(context))
                                : Expanded(
                                    flex: 4,
                                    child: SearchUserFromRepo(
                                      searchJCode: searchJCode,
                                    )),
                          ],
                        ),
                      ),
                      ConnectPage()
                    ],
                  )))),
    );
  }
}

/*

 */
