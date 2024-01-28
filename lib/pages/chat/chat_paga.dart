import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rive/rive.dart';
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

  //scroll contrller
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CusColors().custPink,
        title: Text(widget.userName),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0XFF212b26),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //chatList ->  StreamBuilder()
            Expanded(child: buildChatList(),),
            //Send message -> TextField()
            buildSendMessage(messageController)
          ],
        ),
      )
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
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        // Scroll to the end after the frame is built
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
      return ListView.builder(
        controller: _scrollController,
        itemCount: snapshot.data!.docs.length,itemBuilder: (context, index){
        DateTime date = DateTime.parse(snapshot.data!.docs[index]['timeStamp'].toDate().toString());
        String time = DateFormat('HH:mm').format(date);
        return messsageItem(snapshot.data!.docs[index]['message'],snapshot.data!.docs[index]['senderUID'], snapshot.data!.docs[index]['senderEmail'],time.toString());
      },);
    });
  }

  Widget buildSendMessage(TextEditingController message) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: CusColors().customGreen,
          borderRadius: BorderRadius.circular(60)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.file_copy,color: Colors.grey, size: 35,),
          ),
          Icon(Icons.camera_alt,color: Colors.grey, size: 35,),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(3.0),
              child: Container(
                child: TextField(
                  controller: message,
                  cursorOpacityAnimates: true,
                  decoration: InputDecoration(
                      hintText: 'Send message...',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                          borderSide: BorderSide(color: Colors.white))),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              if(messageController.text.isNotEmpty){
                ChatService().sendMessage(widget.userUID, messageController.text);
                messageController.text = '';
              }
              Vibration.vibrate(duration: 100);
            },
            child: Container(
              width: 50,
              height: 50,
              child: RiveAnimation.asset('asset/riv/send_button_anim.riv'),
            ),
          )
        ],
      ),

    );
  }
}
