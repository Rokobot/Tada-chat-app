import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel{
  final String userUID ;
  final String userName;

  NotificationModel({required this.userUID, required this.userName});

  //Conver to map
  Map<String, dynamic> toMap(){
    return {
      'userUID': userUID,
      'userName': userName,
    };
  }

}