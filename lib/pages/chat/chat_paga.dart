import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tada/components/const.dart';
import 'package:tada/services/chat_service.dart';
import 'package:vibration/vibration.dart';

import '../../components/variables/components.dart';

class ChatPage extends StatefulWidget {
  final String userName;
  final String userUID;
  const ChatPage({super.key, required this.userName, required this.userUID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //message text
  TextEditingController messageController = TextEditingController();
  //current user UID
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //chatList ->  StreamBuilder()
          Expanded(flex:10 ,child: buildChatList(),),
          //Send message -> TextField()
          Flexible( flex: 1, child: buildSendMessage(messageController))
        ],
      ),
    );
  }

  buildChatList() {
    return StreamBuilder(stream: ChatService().getMessage( firebaseAuth.currentUser!.uid, widget.userUID ), builder: (context, snapshot){
      if(snapshot.hasError){
        return Center(child: Text(snapshot.error.toString()),);
      }
      if(!snapshot.hasData){
        return Center(child: Text('No have any data!'),);
      }
      if(snapshot.connectionState == ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(color: Colors.blue,),);
      }
      return ListView.builder( itemCount: snapshot.data!.docs.length,itemBuilder: (context, index){
        DateTime date = DateTime.parse(snapshot.data!.docs[index]['timeStamp'].toDate().toString());
        String time = DateFormat('HH:mm').format(date);
        return messsageItem(snapshot.data!.docs[index]['message'],snapshot.data!.docs[index]['senderUID'], snapshot.data!.docs[index]['senderEmail'],time.toString());
      },);
    });
  }

  Widget buildSendMessage(TextEditingController message) {
    return Container(
      decoration: BoxDecoration(
          color: CusColors().customGreen,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(3.0),
              child: TextField(
                controller: message,
                cursorOpacityAnimates: true,
                decoration: InputDecoration(
                    hintText: 'Send message...',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.white))),
              ),
            ),
          ),
          IconButton(
            focusColor: Colors.greenAccent,
               hoverColor: Colors.green,
              splashColor: Colors.green,
              highlightColor: Colors.green,
              onPressed: () {
              ChatService().sendMessage(widget.userUID, messageController.text);
              messageController.text = '';
            Vibration.vibrate(duration: 100);
          }, icon: Icon(Icons.send))
        ],
      ),
    );
  }
}
