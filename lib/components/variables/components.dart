import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tada/components/const.dart';
import 'package:tada/pages/chat/chat_paga.dart';

import 'package:vibration/vibration.dart';

import '../methods/methods.dart';


//show  all users in gridview
Widget userItem(String username, String profilePhoto, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: (){
        nextScreen(context, ChatPage(userName: username));
      },
      child: Container(
        decoration: BoxDecoration(
          color:CusColors().customGreen,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 100, // Set the desired height
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Column(
            children: [
              Expanded(
                  child: profilePhoto == ''
                      ? CircleAvatar(
                          radius: 55,
                          child: Text(
                            username.substring(0, 1).toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      : CircleAvatar(
                          child: Image.network(profilePhoto),
                        )),
              Expanded(
                child: Text(username,style: TextStyle(color: Colors.white),),
              ),
              Expanded(child: Container( decoration: BoxDecoration(color: CusColors().cusGreenYellow, borderRadius: BorderRadius.circular(25)), child: Center(child: Text('say hello', style: TextStyle(color: Colors.black),))))
            ],
          )),
        ),
      ),
    ),
  );
}

//Textfield for search any user
Widget searchItem(String text, TextEditingController controller,
    void Function(String)? func) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        onChanged: func,
        controller: controller,
        cursorWidth: 10,
        cursorHeight: 10,
        cursorColor: Colors.yellow,
        cursorOpacityAnimates: true,
        style: TextStyle(height: 0.5),
        decoration: InputDecoration(
            hintText: text,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.indigo.shade50,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.yellow,
                ))),
      ),
    ),
  );
}

//Result of seacrh
showItem(QuerySnapshot<Map<String, dynamic>> data, BuildContext context) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
    itemBuilder: (context, index) {
      return userItem(data.docs[index]['userName'], '', context);
    },
    itemCount: data!.docs.length,
  );
}


//This items show when you searched user from search
seacrhResultItem(QuerySnapshot<Map<String, dynamic>> data) {
  return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 8, mainAxisSpacing: 8),
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: CusColors().cusYellow,
              borderRadius: BorderRadius.circular(50)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar( radius: 40,child: Text(data.docs[index]['email'].toString().substring(0,1), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),)),
              Text(data.docs[index]['userName'], style: TextStyle(color: Colors.black),),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(CusColors().cusGreenYellow)),
                  onPressed: () {
                    Vibration.vibrate(duration: 90);
                  },
                  child: Text('connect', style: TextStyle(color: Colors.black),))
            ],
          ),
        ),
      );
    },
    itemCount: data!.docs.length,
  );
}



//Last searched user item
lastSearched(String name, void Function() func){
  return GestureDetector(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(decoration:  BoxDecoration(borderRadius:  BorderRadius.circular(10), color: Colors.yellow),child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text(name,style: TextStyle(color: Colors.black),)),
      ),),
    ),
    onLongPress: func,
  );
}


//ListTile to settings
customListTile(Text text, dynamic element){
  return ListTile(title: text,trailing: element,);
}