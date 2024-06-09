import 'package:flutter/material.dart';
import '/constants/color.dart';

Widget CommomLoader(){

  return const Center(
    child: CircularProgressIndicator(
      color: MyColors.primary,
    ),
  );

}