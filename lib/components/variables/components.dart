import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget userItem(String username, String profilePhoto) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      hoverColor: Colors.blue,
      focusColor: Colors.red,
      splashColor: Colors.green,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.indigo.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 100, // Set the desired height
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Expanded(child: profilePhoto == '' ? CircleAvatar(radius: 55, child: Text(username.substring(0,1).toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold),),) : CircleAvatar(child: Image.network(profilePhoto),)),
                Expanded(child: Text(username),),
                Expanded(child: Text('say hello'))
              ],
            )
          ),
        ),
      ),
    ),
  );
}



//Search item
 Widget searchItem(String text, TextEditingController controller){
   return Container(
     color: Colors.indigo.shade200,
     child: Padding(
       padding: const EdgeInsets.all(10),
       child: TextField(
         controller: controller,
         cursorWidth: 10,
         cursorHeight: 10,
         cursorColor: Colors.yellow,
         cursorOpacityAnimates: true,
         style: TextStyle(height: 0.5),
           decoration: InputDecoration(
             hintText: text,
             enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide:  BorderSide(color: Colors.indigo.shade50,)),
             focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide:  BorderSide(color: Colors.yellow,))
           ),

       ),
     ),
   );
 }