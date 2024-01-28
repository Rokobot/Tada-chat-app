import 'package:flutter/material.dart';
import 'package:tada/components/const.dart';
import 'package:vibration/vibration.dart';
import '../../components/methods/methods.dart';
import '../profile_page.dart';


class CustomDrawer extends StatefulWidget {
  String profilePhoto;
  String userName;
  String email;
  String jcode;
  CustomDrawer({super.key, required this.profilePhoto, required this.userName, required this.email, required this.jcode});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  //Theme changer
  bool valueTheme = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DrawerHeader(child: Column(
                children: [
                  Text('Tada', style: TextStyle(fontSize: 80, fontFamily: 'Cosmic'),),
                ],
              ),),
              Flexible(flex: 3,
                  child: widget.profilePhoto == '' ? CircleAvatar(child: Text(
                    widget.userName.substring(0, 1),
                    style: TextStyle(fontSize: 40),),):CircleAvatar( backgroundImage: ExactAssetImage(widget.profilePhoto),radius: 80,)),
              Flexible(flex: 1,
                  child: Text('My name is ${widget.userName}', style: TextStyle(fontSize: 20))),
              Spacer(),
              Flexible(flex: 1,
                  child: InkWell(
                    highlightColor: Colors.green,
                    splashColor: Colors.grey,
                    onTap: (){
                      Vibration.vibrate(duration: 90);
                      nextScreen(context, ProfilePage(email: widget.email, JCode: widget.jcode, userName: widget.userName,));
                    },
                    child: ListTile(
                      leading: Icon(Icons.person_3), title: Text('Profile'),),
                  )),
              Flexible(flex: 1,
                  child: InkWell(
                    highlightColor: Colors.green,
                    splashColor: Colors.grey,
                    child: ListTile(
                      leading: Icon(Icons.settings), title: Text('Settings')),
                    onTap: () {
                      Vibration.vibrate(duration: 90);
                      nextScreenNamed(context, '/Settings');
                    },)),
              Flexible(flex: 4, child: Container()),
              Flexible(flex: 1,
                  child: Text('Developed: by Ali Hasanov',
                      style: TextStyle(fontSize: 12)))
            ],
          ),
        )
    );
  }
}