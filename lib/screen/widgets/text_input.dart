import 'package:flutter/material.dart';
import 'package:found1/const.dart';

class textinputfields extends StatelessWidget {
  final TextEditingController controller;
  final IconData myIcon;
  final String mylabeltext;
  final bool tohide;
  textinputfields({
    Key? key,
    required this.controller,
    required this.myIcon,
    required this.mylabeltext,
    this.tohide = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: tohide,
      controller: controller,
      decoration: InputDecoration(
        icon: Icon(myIcon),
        labelText: mylabeltext,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.deepPurpleAccent)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: borderColor,
            )),
      ),
    );
  }
}
