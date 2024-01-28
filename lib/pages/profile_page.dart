import 'package:flutter/material.dart';
import 'package:tada/components/const.dart';

class ProfilePage extends StatefulWidget {
  final String userName;
  final String email;
  final String JCode;
  const ProfilePage(
      {super.key,
      required this.userName,
      required this.email,
      required this.JCode});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 10,),
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: Icon(Icons.arrow_back_ios)),
              Spacer(),
              Card(elevation: 10, child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.edit_note_sharp, size: 33,),
              )),
                SizedBox(width: 10,),
            ],),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: CircleAvatar(
                  child: CircleAvatar(radius: 60, backgroundImage: ExactAssetImage('asset/images/profile_photo.jpg'),),
                  radius: 60,
                ),
              ),
            ),
            SizedBox(height: 30,),
            Card(
                color: CusColors().custCosmic,
                elevation: 10, child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('  ${widget.userName}', style: TextStyle(fontSize: 16, color: Colors.white),),
            )),
            Card(
                color: CusColors().custCosmic,
                elevation: 10, child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('  ${widget.email}', style: TextStyle(fontSize: 16, color: Colors.white),),
            )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                  color: CusColors().custCosmic,
                  elevation: 10, child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Thanks to Tada, I made new friends. I learned their language, culture, and cuisine. Tada is a truly wonderful application.', style: TextStyle(fontSize: 15, color: Colors.white), textAlign: TextAlign.center,),
              )),
            ),
            Expanded(
              child: GridView.builder( shrinkWrap: true, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount: 2, childAspectRatio: 2, ), itemCount: 2,itemBuilder: (contex, index){
                List<dynamic> joinCodeAndConnect = ['${widget.JCode} ', '10'];
                List<dynamic> nameJoinCodeAndConnect = ['JCODE ', 'Connection'];

                return Card(
                    color: CusColors().custDark,
                    elevation: 10, child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text(nameJoinCodeAndConnect[index], style: TextStyle(fontSize: 16, color: Colors.white),),
                    Text(joinCodeAndConnect[index], style: TextStyle(fontSize: 32, color: Colors.white),)
                  ],)),
                ));
              }),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                  color: Colors.red,
                  elevation: 10, child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Sign out', style: TextStyle(fontSize: 15,), textAlign: TextAlign.center,),
              )),
            ),

            SizedBox(height: 30,),


          ],
        ),
      ),
    );
  }
}
