import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String senderUID;
  final String recieveUID; //target user UID
  final String senderEmail;
  final String message;
  final Timestamp timeStamp;

  ChatModel(
      {required this.senderUID,
      required this.recieveUID,
      required this.senderEmail,
      required this.message,
      required this.timeStamp});

  //Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'senderUID': senderUID,
      'recieveUID': recieveUID,
      'senderEmail': senderEmail,
      'message': message,
      'timeStamp': timeStamp
    };
  }
}
