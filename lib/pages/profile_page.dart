import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String userName;
  final String email;
  final String JCode;
  const ProfilePage(
      {super.key,
      required this.userName,
      required this.email,
      required this.JCode});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.userName}\'s profile👀'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Text(widget.userName.substring(0,1),style: TextStyle(fontSize: 60),),
              radius: 60,
            ),
            Divider(indent: 25,endIndent: 25,),
            Text(widget.userName),
            Text(widget.email),
            Text(widget.JCode)
          ],
        ),
      ),
    );
  }
}
