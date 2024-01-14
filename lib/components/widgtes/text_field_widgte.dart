import 'package:flutter/material.dart';



//custom textformfield
class textFormFieldComponent extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  bool visibleOrInvisible;
  String? Function(String?)?  validate;
  String? hint;
  textFormFieldComponent({super.key, required this.controller, required this.visibleOrInvisible, required this.validate, required this.hint});

  @override
  State<textFormFieldComponent> createState() => _textFormFieldComponentState();
}
class _textFormFieldComponentState extends State<textFormFieldComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.visibleOrInvisible,
        validator: widget.validate,
        decoration: InputDecoration(
          suffixIcon: widget.hint == 'Email' || widget.hint == 'Username' ? Icon(Icons.email) : GestureDetector( onTap: (){setState(() {
            widget.visibleOrInvisible =! widget.visibleOrInvisible;
          });}, child: widget.visibleOrInvisible ? Icon(Icons.visibility_off): Icon(Icons.visibility)),
          hintText: widget.hint,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.yellow)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.green)),
        ),
      ),
    );
  }
}