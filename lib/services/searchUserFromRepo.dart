import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tada/components/const.dart';
import 'package:tada/components/variables/components.dart';
import 'package:tada/helper/helper_function.dart';
import 'package:vibration/vibration.dart';

import '../components/methods/methods.dart';
import '../pages/chat/chat_paga.dart';

class SearchUserFromRepo extends StatefulWidget {
  final String user;
  const SearchUserFromRepo({super.key, required this.user});

  @override
  State<SearchUserFromRepo> createState() => _SearchUserFromRepoState();
}

class _SearchUserFromRepoState extends State<SearchUserFromRepo> {
  //last searched username
  List<String> lastUsers = [];
  //Firebase
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lastUser();
  }

  lastUser() {
    HelperFunction().getLastSearchUserNames().then((value) {
      setState(() {
        lastUsers = value;
        print(lastUsers);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Align(
            child: Text(
              '     Last seacrhed',
              style: TextStyle(fontSize: 18),
            ),
            alignment: Alignment.topLeft,
          ),
          Divider(
            endIndent: 25,
            indent: 25,
          ),
          Flexible(
              flex: 2,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return lastSearched(lastUsers[index], () {
                    Vibration.vibrate(duration: 100);
                    HelperFunction().removeItemFromIndex(index);
                  });
                },
                itemCount: lastUsers.length,
              )),
          Flexible(
              flex: 7,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .where('JCode', isEqualTo: widget.user)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No user found!'));
                  }

                  return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Align(
                            child: Text(
                              '     Found user',
                              style: TextStyle(fontSize: 18),
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Divider(
                            endIndent: 25,
                            indent: 25,
                          ),
                          Expanded(
                            child: GestureDetector(
                              child: seacrhResultItem(snapshot.data!),
                              onTap: () {
                                if(snapshot.data!.docs[0]['email'] != auth.currentUser!.email.toString()){
                                  nextScreen(context, ChatPage(userName:snapshot.data!.docs[0]['userName'] ));
                                }
                                setState(() {
                                  HelperFunction()
                                      .saveLastSearchUserName(widget.user);
                                });
                              },
                            ),
                          )
                        ],
                      ));
                },
              ))
        ],
      ),
    );
  }
}
