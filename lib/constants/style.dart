import 'package:flutter/material.dart';
import '/constants/color.dart';
import 'string.dart';

class MyStyle {
  MyStyle._();

  static ButtonStyle submitButtonStyle = ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    ),
    backgroundColor: MaterialStateProperty.all(MyColors.primary),
  );

  static const TextStyle appBarText = TextStyle(
    fontSize: 20,
  );

  static TextStyle tweetHandle = const TextStyle(
    fontFamily: 'Segoe',
    color: MyColors.darkGrey,
    fontSize: 16.0,
  );

  static TextStyle tweetText = const TextStyle(
    fontFamily: 'Segoe',
    color: MyColors.secondary,
    fontSize: 16.0,
  );

  static TextStyle postButton = const TextStyle(
    fontFamily: 'Segoe',
    color: MyColors.white,
    fontSize: 16.0,
  );

  static TextStyle profileText = const TextStyle(
      fontFamily: 'Segoe',
      color: MyColors.secondary,
      fontSize: 16.0,
      fontWeight: FontWeight.w900);

  static TextStyle headingName = const TextStyle(
    fontFamily: 'Segoe',
    fontWeight: FontWeight.w900,
    color: MyColors.secondary,
    fontSize: 20.0,
  );

  static InputDecoration registerForm({required String hintText}){
  
  return InputDecoration(
    hintText: hintText,
    fillColor: MyColors.inputField,
    filled: true,
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
      borderSide: BorderSide(color: MyColors.inputField),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
      borderSide: BorderSide(color: MyColors.inputField),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
      borderSide: BorderSide(color: MyColors.inputField),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
  );
}
}
