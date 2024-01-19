import 'package:flutter/material.dart';


nextScreenNamed (BuildContext context, String text){
  Navigator.pushNamed(context, text)   ;
}


replaceScreenNamed (BuildContext context, String text){
  Navigator.pushReplacementNamed(context, text);
}


nextScreen(BuildContext context, Widget page){
  Navigator.push(context, MaterialPageRoute(builder: (context)=> page));
}

