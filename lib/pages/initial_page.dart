import 'dart:async';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tada/components/const.dart';
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
            child: SizedBox(
              width: 600,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(70),
                    bottomLeft: Radius.circular(70),
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Tada', style: TextStyle(color: Colors.white, fontSize: 80, fontFamily: 'Cosmic'),),
                    Text('Your new home', style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'Cosmic')),
                    SizedBox(height: 40,)
                  ],
                ),
              ),

            ),
          ),
          Positioned(
          bottom: 30,
              left:90,
              child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(CusColors().customGreen)),
                  onPressed: (){
                checkRepo();
              }, child: Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 160,
                  child: Center(child: Text('get Start', style: TextStyle(color: Colors.white, fontFamily: 'Cosmic', fontSize: 20),))),
                            )))),
          Positioned(
              bottom: 10,
              left: 116,
              child: Text('Developed by Ali Hasanov')),

        ],
      )
    );
  }
}
