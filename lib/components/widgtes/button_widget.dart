import 'package:flutter/material.dart';
import 'package:tada/components/const.dart';


class buttonComponent extends StatefulWidget {
  void Function() func;
  String text;
  buttonComponent({super.key, required this.func, required this.text});

  @override
  State<buttonComponent> createState() => _buttonComponentState();
}

class _buttonComponentState extends State<buttonComponent> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.func,
      child: Container(child: Center(child: Text( widget.text, style: TextStyle(color: Colors.white),)),width: 150,height: 50,),
      style: ButtonStyle(
          backgroundColor:MaterialStateProperty.all(CusColors().customGreen),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
    );;
  }
}
