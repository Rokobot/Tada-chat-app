import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tada/components/variables/components.dart';
import 'package:tada/state_managment/searched_story/searched_story_bloc.dart';
import 'package:vibration/vibration.dart';

import '../components/methods/methods.dart';
import '../pages/chat/chat_paga.dart';

class SearchUserFromRepo extends StatefulWidget {
  final String searchJCode;
  const SearchUserFromRepo({super.key, required this.searchJCode});

  @override
  State<SearchUserFromRepo> createState() => _SearchUserFromRepoState();
}

class _SearchUserFromRepoState extends State<SearchUserFromRepo> {
  //Firebase
  final FirebaseAuth auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchedStoryBloc, SearchedStoryState>(
      builder: (BuildContext context, SearchedStoryState state) { 
        if(state is SearchedStoryInitial){
          return buildScaffoldSearch([]);
        }
        if(state is SearchListState){
          return buildScaffoldSearch(state.JCodeList);
        }
        return buildScaffoldSearch([]);
      },
       
    );
  }

  //Method to BlocBuilder
  Scaffold buildScaffoldSearch(List<String> JCodeList) {
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

                      print(widget.searchJCode);
                      return GestureDetector(child: lastSearched(JCodeList[index]),onTap: (){
                        Vibration.vibrate(duration: 100);
                        print(widget.searchJCode);
                        context.read<SearchedStoryBloc>().add(DeleteItemToListEvent(JCode: JCodeList[index]));
                        print('Islek');
                      },);
                    },
                    itemCount: JCodeList.length,
                  )),
              Flexible(
                  flex: 7,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Users')
                        .where('JCode', isEqualTo: widget.searchJCode)
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
                                      nextScreen(context, ChatPage(userName:snapshot.data!.docs[0]['userName'] , userUID: snapshot.data!.docs[0]['userUID'],));
                                      setState(() {
                                        context.read<SearchedStoryBloc>().add(AddItemToListEvent(JCode: widget.searchJCode));
                                      });
                                    }

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
