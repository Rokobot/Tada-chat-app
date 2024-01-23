import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tada/components/const.dart';
import 'package:tada/models/notification_model.dart';
import '../components/variables/components.dart';

class NotfService extends ChangeNotifier {
  //fetch notf list size and items
  notfListShow(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .where('userUID', isEqualTo: firebaseAuth.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text('No have any data!'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        }
        List<dynamic> data = snapshot.data!.docs[0]['notfList'];
        return notfItem(data.length, context);
      },
    );
  }

  sendConnectNotf(String targetUserUID) async {
    String currentUserUID = FirebaseAuth.instance.currentUser!.uid.toString();
    FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUserUID)
        .get()
        .then((value) async {
      Map<String, dynamic>? map = value.data();
      String userName = map?['userName'];
      DocumentReference documentReference = await FirebaseFirestore.instance
          .collection('Users')
          .doc(targetUserUID);
      List<String> userInfoList = [currentUserUID, userName];
      userInfoList.sort();
      String userInfo = userInfoList.join('_');
      NotificationModel notificationModel =
          NotificationModel(notfList: FieldValue.arrayUnion([userInfo]));
      documentReference.update(notificationModel.toMap());
    });
  }

  requestToConnectionList() {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .where('userUID', isEqualTo: firebaseAuth.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text('No have any data!'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          List<dynamic> data = snapshot.data!.docs[0]['notfList'];

          if (data.length != 0) {
            String userInfoString = data[0];
            List<String> userInfo = userInfoString.split('_');
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return notfReqItem(userInfo[1]);
                });
          }
          return Container();
        });
  }
}
