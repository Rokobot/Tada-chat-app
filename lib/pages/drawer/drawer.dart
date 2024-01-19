import 'package:flutter/material.dart';
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
              Flexible(flex: 1,
                  child: CircleAvatar(radius: 60,
                    child: widget.profilePhoto == '' ? Text(
                      widget.userName.substring(0, 1),
                      style: TextStyle(fontSize: 40),) : Image.network(
                      widget.profilePhoto,),)),
              Flexible(flex: 1,
                  child: Text(widget.userName, style: TextStyle(fontSize: 20))),
              Flexible(flex: 1,
                  child: Text(widget.email, style: TextStyle(fontSize: 15))),
              Flexible(flex: 1,
                  child: Text(widget.jcode, style: TextStyle(fontSize: 15))),
              Spacer(),
              Flexible(flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      nextScreen(context, ProfilePage(email: widget.email, JCode: widget.jcode, userName: widget.userName,));
                    },
                    child: ListTile(
                      leading: Icon(Icons.person_3), title: Text('Profile'),),
                  )),
              Flexible(flex: 1,
                  child: GestureDetector(child: ListTile(
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