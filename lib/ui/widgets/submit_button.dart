import 'package:flutter/material.dart';
import '/constants/style.dart';

import '../../utils/ui_util.dart';

class SubmitButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const SubmitButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 35),
      child: TextButton(
        style: MyStyle.submitButtonStyle,
        onPressed: () {
         UiUtil.debugPrint('button pressed with $onPressed');
          onPressed();
        },
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
