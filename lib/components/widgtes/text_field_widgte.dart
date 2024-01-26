import 'package:flutter/material.dart';



//custom textformfield
class textFormFieldComponent extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  bool visibleOrInvisible;
  String? Function(String?)?  validate;
  String? hint;
  IconData? icon;

  textFormFieldComponent({super.key, required this.controller, required this.visibleOrInvisible, required this.validate, required this.hint, required this.icon});

  @override
  State<textFormFieldComponent> createState() => _textFormFieldComponentState();
}
class _textFormFieldComponentState extends State<textFormFieldComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: widget.controller,
        obscureText: widget.visibleOrInvisible,
        validator: widget.validate,
        decoration: InputDecoration(
          prefixIcon:Icon(widget.icon, color: Colors.white,),
          suffixIcon: widget.hint == 'Email' || widget.hint == 'Username' ? SizedBox() : GestureDetector( onTap: (){setState(() {
            widget.visibleOrInvisible =! widget.visibleOrInvisible;
          });}, child: widget.visibleOrInvisible ? Icon(Icons.visibility_off): Icon(Icons.visibility)),
          hintText: widget.hint,
          hintStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.green)),
        ),
      ),
    );
  }
}