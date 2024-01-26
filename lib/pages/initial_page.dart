import 'dart:async';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tada/components/methods/methods.dart';
import 'package:video_player/video_player.dart';

import '../services/fetchUserFromRepo.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController = VideoPlayerController.asset("asset/video/into_video.mp4");
    _videoPlayerController.initialize().then((_) {
      _videoPlayerController.setLooping(true);
      _videoPlayerController.play();
    });
  }


  checkRepo() async{

     //Get info to choise first screen
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.authStateChanges().listen((event) {

      if(event != null){
        replaceScreenNamed(context, '/HomePage');
      }else{
        replaceScreenNamed(context, '/SignUpPage');
      }
    });


  }
  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    _videoPlayerController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            child: VideoPlayer(_videoPlayerController),
          ),
          Container(color: Colors.black.withOpacity(0.4),),
          Positioned(
            top: 50,
            left: 20,
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Tada', style: TextStyle(color: Colors.white, fontSize: 50),),
                  Text('Your new home', style: TextStyle(color: Colors.white, fontSize: 30)),
                ],
              ),

            ),
          ),
          Positioned(
          bottom: 10,
              left: 150,
              child: ElevatedButton(onPressed: (){
                checkRepo();
              }, child: Text('Start')))
        ],
      )
    );
  }
}
