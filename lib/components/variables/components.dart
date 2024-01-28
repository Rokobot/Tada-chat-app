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
      child: Card(
        color: CusColors().custPink,
        elevation: 10,
        // Set the desired height
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Column(
            children: [
              profilePhoto == '' ? CircleAvatar(child: Text(
                username.substring(0, 1),
                style: TextStyle(fontSize: 40),),):CircleAvatar( backgroundImage: ExactAssetImage(profilePhoto),radius: 40,),
              Expanded(
                child: Text(
                  username,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(child: Text(
                textAlign: TextAlign.center,
                'Hello i am using tada and very good app like it really',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 10, color: Colors.white),
              ) ),
              Expanded(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Baku', style: TextStyle(color: Colors.white),),
                      Spacer(),
                      InkWell(
                        radius: 10,
                        focusColor: Colors.white,
                        hoverColor: Colors.blue,
                        splashColor: Colors.green,
                        onTap: (){
                          NotfService().sendConnectNotf(UID);
                          Vibration.vibrate(duration: 100);
                        },
                        child: Ink(
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [CusColors().cusPinkShade700, CusColors().cusPinkShade100,], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                          ),
                          child: Center(child: Text('CONNECT', style: TextStyle(color: Colors.white),)),
                        ),
                      )
                    ],
                  ))
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
        'asset/images/profile_photo.jpg',
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
                    backgroundColor:
                        MaterialStateProperty.all(CusColors().cusGreenYellow)),
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
lastSearched(
  String name,
) {
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
              decoration: BoxDecoration(
                  color: CusColors().customGreen,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: 300),
                      decoration: BoxDecoration(  border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          textAlign:TextAlign.justify,
                          message,
                          style: TextStyle(fontSize: 21, color: Colors.white,),
                        ),
                      ),
                    ),
                    Text(
                      timeStamp,
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
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
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(100),
                      topLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
               Container(
                 decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(50)),
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text(
                     textAlign: TextAlign.justify,
                     message,
                     style: TextStyle(fontSize: 21, color: Colors.white),
                   ),
                 ),
               ),
                    Text(
                      timeStamp,
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
}

notfItem(int data, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
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
              child: Icon(
                Icons.notifications,
                color: Colors.white,
                size: 30,
              ),
            ),
            Positioned(
                top: 18,
                right: 12,
                child:data == 0 ? Container() :  CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  radius: 10,
                  child: Text(
                    data.toString(),
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                )),
          ],
        ),
      ),
    ),
  );
}

notfReqItem(String userName, int index) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Ink(
      decoration: BoxDecoration(
          color: CusColors().custPink,
          borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {},
        focusColor: Colors.blue,
        child: ListTile(
          title: Text.rich(TextSpan(
              text: '${userName}',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
              children: [
                TextSpan(
                    text: ' send you connection',
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 15))
              ])),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    NotfService().acceptRequest(userName, index);
                  },
                  child: Text(
                    'accept', style: TextStyle(color: Colors.green),
                  )),
              SizedBox(width: 5,),
              TextButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () {
                    NotfService().rejectRequest(index);
                  },
                  child: Text(
                    'reject', style: TextStyle(color: Colors.red),
                  ))
            ],
          ),
        ),
      ),
    ),
  );
}
