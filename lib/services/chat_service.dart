import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tada/models/chat_model.dart';

class ChatService extends ChangeNotifier {
  //Save all message
  Future<void> sendMessage(String recieveUserUID, String message) async {
    final String currentUserUID = FirebaseAuth.instance.currentUser!.uid;
    final String currentUserEmail =
        FirebaseAuth.instance.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    ChatModel newMessage =  ChatModel(
        senderUID: currentUserUID,
        recieveUID: recieveUserUID,
        senderEmail: currentUserEmail,
        message: message,
        timeStamp: timestamp);

    List<String> UIDs = [currentUserUID, recieveUserUID];
    UIDs.sort();
    String chatRoomUID = UIDs.join('_');

    await FirebaseFirestore.instance.collection('chat_rooms').doc(chatRoomUID).collection('message').add(newMessage.toMap());
  }

  //Get all message
  Stream<QuerySnapshot> getMessage(String currentUserUID, String recieveUserUID){
    List<String> UIDs = [currentUserUID , recieveUserUID];
    UIDs.sort();
    String chatRoomUID = UIDs.join('_');
    
    return FirebaseFirestore.instance.collection('chat_rooms').doc(chatRoomUID).collection('message').orderBy('timeStamp', descending: false).snapshots();
  }
}
