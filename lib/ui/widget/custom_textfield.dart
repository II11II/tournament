import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
final TextInputType textInputType;
final String Function(String) validator;
final bool autoValidate;
final String hintText;
final bool obscureText;
final Function onChanged;
  const CustomTextField({Key key, this.controller, this.textInputType, this.obscureText, this.validator, this.hintText, this.autoValidate, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: obscureText??false,
      keyboardType: textInputType,
      validator: validator,
      autovalidate: autoValidate??false,
      controller: controller,style: TextStyle(color: Colors.white),
      decoration: InputDecoration(hintText: hintText,
        fillColor: Color.fromRGBO(85, 148, 244, 0.1),
        filled: true,
    hintStyle: TextStyle(color: Colors.grey.shade400),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 0),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 0),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 0),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
