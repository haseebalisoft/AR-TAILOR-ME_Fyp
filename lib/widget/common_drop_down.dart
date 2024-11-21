import 'package:flutter/material.dart';

class CommonDropDown extends StatelessWidget {
  final List<dynamic> options;
  final String labelText;
  final Function(dynamic value) onChange;
  final String initalValue;

  const CommonDropDown({
    Key? key,
    required this.options,
    required this.labelText,
    required this.onChange,
    required this.initalValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<dynamic>(
      initialSelection: initalValue,
      menuHeight: 200,
      leadingIcon: Icon(
        Icons.design_services,
        color: Theme.of(context).primaryColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        hintStyle: TextStyle(color: Colors.black),
        labelStyle: TextStyle(color: Colors.black),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 2.0, horizontal: 15),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade100),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
      ),
      label: Text(labelText),
      width: 310,
      dropdownMenuEntries: options
          .map((option) => DropdownMenuEntry(value: option, label: option))
          .toList(),
      onSelected: (value) {
        onChange(value.toString());
      },
    );
  }
}
