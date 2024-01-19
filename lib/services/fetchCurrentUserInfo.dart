import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tada/pages/drawer/drawer.dart';

class FetchCurrentUserInfo {
   getCurrentInfo() {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .where('userUID', isEqualTo: firebaseAuth.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()),);
          }
          if(!snapshot.hasData){
            return Center(child: Text('No have any data!'),);
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(color: Colors.blue,),);
          }
          QuerySnapshot<Map<String, dynamic>>  data = snapshot.data!;
          return CustomDrawer(email: data.docs[0]['email'],userName: data.docs[0]['userName'],profilePhoto: '',jcode: data.docs[0]['JCode']);
        });
  }
}
