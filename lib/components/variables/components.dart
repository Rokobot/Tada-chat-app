import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tada/components/const.dart';
import 'package:tada/pages/chat/chat_paga.dart';
import 'package:tada/pages/notfication_page.dart';
import 'package:tada/services/notfService.dart';
import 'package:vibration/vibration.dart';
import '../methods/methods.dart';

//show  all users in gridview
Widget userItem(
    String username, String profilePhoto, BuildContext context, String UID) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: () {
        nextScreen(
            context,
            ChatPage(
              userName: username,
              userUID: UID,
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: CusColors().customGreen,
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
                child: Text(
                  username,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: CusColors().cusGreenYellow,
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                          child: TextButton(
                            onPressed: (){
                              NotfService().sendConnectNotf(UID);
                              print('Hello');
                            },
                            child: Text(
                              'connect',
                              style: TextStyle(color: Colors.black),
                            ),
                          ))))
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
      return userItem(
        data.docs[index]['userName'],
        '',
        context,
        data.docs[index]['userUID'],
      );
    },
    itemCount: data!.docs.length,
  );
}

//This items show when you searched user from search
seacrhResultItem(QuerySnapshot<Map<String, dynamic>> data) {
  return ListView.builder(
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: CusColors().cusYellow,
          ),
          child: ListTile(
            leading: CircleAvatar(
                radius: 20,
                child: Text(
                  data.docs[index]['email']
                      .toString()
                      .substring(0, 1)
                      .toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                )),
            trailing: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        CusColors().cusGreenYellow)),
                onPressed: () {
                  Vibration.vibrate(duration: 90);
                },
                child: Text(
                  'connect',
                  style: TextStyle(color: Colors.black),
                )),
            title: Text(
              data.docs[index]['userName'],
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
      );
    },
    itemCount: data!.docs.length,
  );
}

//Last searched user item
lastSearched(String name,) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.yellow),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Text(
          name,
          style: TextStyle(color: Colors.black),
        )),
      ),
    ),
  );
}

//ListTile to settings
customListTile(Text text, dynamic element) {
  return InkWell(
      onTap: () {},
      highlightColor: Colors.green,
      splashColor: Colors.blue,
      child: ListTile(
        title: text,
        trailing: element,
      ));
}

//Message Item
messsageItem(String message, String UID, String sender, String timeStamp) {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  return UID == firebaseAuth.currentUser!.uid
      ? Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          alignment: Alignment.centerRight,
          width: 100, // Set the width as per your requirement
          child: Container(
            decoration: BoxDecoration(color: CusColors().customGreen, borderRadius: BorderRadius.only(topRight: Radius.circular(100), topLeft: Radius.circular(100), bottomLeft: Radius.circular(100))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(message, style: TextStyle(fontSize: 21, color: Colors.white),),
                  Text(timeStamp, style: TextStyle(fontSize: 10, color: Colors.white),),
                ],
              ),
            ),
          ),
        ),
      )
      : Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
      alignment: Alignment.centerLeft,
      width: 100, // Set the width as per your requirement
      child: Container(
        decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.only(topRight: Radius.circular(100), topLeft: Radius.circular(100), bottomRight: Radius.circular(100))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(message, style: TextStyle(fontSize: 21, color: Colors.white),),
              Text(timeStamp, style: TextStyle(fontSize: 10, color: Colors.white),),
            ],
          ),
        ),
      ),
    ),
  );
}

notfItem(int data, BuildContext context){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: (){
        nextScreen(context, NotificationPage());
      },
      highlightColor: Colors.green,
      focusColor: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              left: 10,
              top: 5,
              child: Icon(Icons.notifications, ) ,
            ),
            Positioned(
              top: 13,
              right: 6,
              child: Text(data == 0 ? "": data.toString(), style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 19),)),
          ],
        ),
      ),
    ),
  );
}


notfReqItem(String userName){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Ink(
      decoration: BoxDecoration( color: CusColors().customGreen,borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: (){},
        focusColor: Colors.blue,
        child: ListTile(
          title: Text.rich(TextSpan(text: '${userName}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),children: [TextSpan(text: ' send you connection', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15))])),),
      ),
    ),
  );
}