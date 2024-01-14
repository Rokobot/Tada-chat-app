import 'package:flutter/material.dart';


extension validate on String {
  //Password check
  passwordOk(){
    if(!(this.length < 6 && this.isEmpty)){
      return true;
    }else{
      return false;
    }
  }

  //Username check
  userNameOk(){
    if(!(this.isEmpty || this.length < 5)){
      return true;
    }else{
      return false;
    }
  }


  //Email check
 emailOk(){
   bool ok  =  RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(this);
   if(this.isNotEmpty && ok){
     return true;
   }else{
     return false;
   }

 }

 //Confirim password
 confirimPassword(String confirim){
    if(this == confirim && this.isNotEmpty){
      return true;
    }else{
      return false;
    }
 }
}