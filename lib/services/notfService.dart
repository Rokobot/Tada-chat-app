import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tada/models/notification_model.dart';
import '../components/variables/components.dart';



class NotfService {

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
      NotificationModel notificationModel =
          NotificationModel(userUID: currentUserUID, userName: userName);
      documentReference.update({
        'notfList': FieldValue.arrayUnion([notificationModel.toMap()])
      });
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
          if (snapshot.data!.docs.isNotEmpty) {
            List<dynamic> data = snapshot.data!.docs[0]['notfList'];
            if (data.length != 0) {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return notfReqItem(data[index]['userName'], index);
                  });
            } else {
              return Center(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    color: Colors.orange,
                    Icons.notifications_active,
                    size: 120,
                  ),
                  Text(
                    'No have any notification',
                    style: TextStyle(color: Colors.orange),
                  )
                ],
              ));
            }
          }
          return Container();
        });
  }

  acceptRequest(String userUID, int index) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    //Delete request from notfList
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    List<dynamic> notfList = documentSnapshot.get('notfList');
    [notfList.removeAt(index)];
    print([notfList]);

    //Add connect list new user
    DocumentReference documentReference2 = await FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseAuth.currentUser!.uid);
    documentReference2.update({
      'connectList': FieldValue.arrayUnion([userUID]),
      'notfList': notfList
    });
  }

  rejectRequest(int index) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    //Delete request from notfList
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    List<dynamic> notfList = documentSnapshot.get('notfList');
    [notfList.removeAt(index)];
    print([notfList]);

    //Add connect list new user
    DocumentReference documentReference2 = await FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseAuth.currentUser!.uid);
    documentReference2.update({'notfList': notfList});
  }

  connetList() {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .where('userUID', isEqualTo: firebaseAuth.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (!snapshot.hasData) {
          return Center(child: Text('No have data!'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.blue,
          ));
        }
        List<dynamic>? data = snapshot.data!.docs[0]['connectList'];
        print(data);
        return data == []
            ? ListView.builder(
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        onTap: () {},
                        splashColor: Colors.greenAccent,
                        child: ListTile(
                            leading: Icon(
                              Icons.connect_without_contact,
                              size: 30,
                            ),
                            title: Text(data![index]),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.share),
                                SizedBox(
                                  width: 20,
                                ),
                                ClipOval(
                                    child: Container(
                                  height: 10,
                                  width: 10,
                                  color: Colors.green,
                                )),
                              ],
                            )),
                      ),
                    ),
                  );
                })
            : Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.connect_without_contact_rounded,
                      size: 120,
                      color: Colors.orange,
                    ),
                    Text(
                      'No have any connection!',
                      style: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }

}
