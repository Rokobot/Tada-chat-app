import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tada/components/variables/components.dart';



class AllUserFetchData{
  CollectionReference _reference = FirebaseFirestore.instance.collection('Users');
  final  _firebaseAuth = FirebaseAuth.instance.currentUser!.uid;
  fetchUserData(){
    return StreamBuilder(stream: FirebaseFirestore.instance.collection('Users').where('userUID', isNotEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(), builder: (context, snapshot){
      if(!snapshot.hasData){
        return Text('Check your internet connection');
      }
      if(snapshot.hasError){
        return Text(snapshot.error.toString());
      }
      if(snapshot.connectionState == ConnectionState.waiting){
        return Center(child: CircularProgressIndicator(color: Colors.blue,),);
      }

      QuerySnapshot<Map<String, dynamic>>? data = snapshot.data;
      return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 8.0, // Spacing between columns
        mainAxisSpacing: 8.0, // Spacing between rows
      ), itemCount:  data!.docs.length,itemBuilder: (context, index){
        return userItem(data.docs[index]['userName'], '');
      });
    });
  }
}