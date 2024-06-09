import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UiUtil{

  UiUtil._();

  static void closeKeyBoard(){
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static String convertTStoTime(int timestamp){
    DateTime convertedTime ;

    try{
      convertedTime = DateTime.fromMicrosecondsSinceEpoch(timestamp); 
      
      return '${convertedTime.hour}:${convertedTime.minute}';
    }
    catch(e){
      return '';
    }
  }

  static void debugPrint(Object? object){
    if (kDebugMode) {
      print(object);
    }
  }


}