import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel{
  final FieldValue notfList;

  NotificationModel({required this.notfList});

  //Conver to map
  Map<String, dynamic> toMap(){
    return {
      'notfList': notfList,
    };
  }

}