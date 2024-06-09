import 'package:flutter/material.dart';
import '/ui/screens/home.dart';
import '../../controller/auth_controller.dart';
import '../screens/register.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    if (AuthController.instance.auth.currentUser != null) {
        return Home();
      } else {
        return Register();
      }
  }
}