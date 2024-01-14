import 'package:flutter/material.dart';


nextScreen (BuildContext context, String text){
  Navigator.pushNamed(context, text)   ;
}


replaceScreen (BuildContext context, String text){
  Navigator.pushReplacementNamed(context, text);
}