import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tada/components/const.dart';
import 'package:tada/components/methods/methods.dart';
import 'package:video_player/video_player.dart';


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
      startTime();
    });

  }

  startTime()async{
    await Future.delayed(Duration(seconds: 4));
    checkRepo();
  }


  checkRepo() async{
     //Get info to choise first screen
    _videoPlayerController.pause();
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
    //checkRepo();
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            child: VideoPlayer(_videoPlayerController),
          ),
          Container(color: Colors.black.withOpacity(0.5),),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 600,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0),
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
              bottom: 10,
              left: 116,
              child: Text('Developed by Ali Hasanov', style: TextStyle(color: Colors.white),)),

        ],
      )
    );
  }
}
