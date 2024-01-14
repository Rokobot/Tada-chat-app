import 'package:flutter/material.dart';


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
      child: Text( widget.text),
      style: ButtonStyle(
          backgroundColor:MaterialStateProperty.all(Colors.yellow),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
    );;
  }
}
