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

  static InputDecoration registerForm = const InputDecoration(
    hintText: MyStrings.enterName,
    fillColor: MyColors.inputField,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
      borderSide: BorderSide(color: MyColors.inputField),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
      borderSide: BorderSide(color: MyColors.inputField),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
      borderSide: BorderSide(color: MyColors.inputField),
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
  );
}
