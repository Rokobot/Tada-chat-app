import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tada/components/variables/components.dart';



//Fetch all user from FirebaseFirestore
class AllUserFetchData{
  FirebaseAuth  _firebaseAuth = FirebaseAuth.instance;
  fetchUserData(BuildContext context){
    try{
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
        return showItem(data!, context,);
      });
    } on FirebaseException catch(e){
      return Text(e.message.toString());
    }
  }
}


