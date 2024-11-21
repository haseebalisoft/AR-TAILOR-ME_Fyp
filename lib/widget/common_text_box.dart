import 'package:flutter/material.dart';

class CommonTextBox extends StatelessWidget {
  final String label;
  final TextInputType textInputType;
  final TextEditingController controller;

  const CommonTextBox({
    super.key,
    required this.controller,
    required this.label,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 17,
          color: Theme.of(context).primaryColor,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.0,
          ),
        ),
      ),
      keyboardType: textInputType,
      controller: controller,
    );
  }
}
