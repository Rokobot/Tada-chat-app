import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:tada/components/const.dart';
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
          backgroundColor: CusColors().custPink,
          drawer: Drawer(
            child: FetchCurrentUserInfo().getCurrentInfo(),
          ),
          body: DefaultTabController(
              length: 2,
              child: NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool scrolled) {
                    return [
                      SliverAppBar(
                        bottom: TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorWeight: 1,
                          physics: BouncingScrollPhysics(),
                          indicatorColor: Colors.blueGrey,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: CusColors().custDarkPalette,
                          ),
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
                        backgroundColor: CusColors().custPink,
                        pinned: true,
                        expandedHeight: 250,
                        flexibleSpace: FlexibleSpaceBar(
                            background: RiveAnimation.asset(
                                'asset/riv/rocket_animation.riv')),
                      )
                    ];

                  },
                  body: TabBarView(
                    physics: BouncingScrollPhysics(),
                    controller: tabController,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                          color: CusColors().custDark,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
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
                      Container()
                    ],
                  )))),
    );
  }
}

/*

 */
