import 'package:flutter/material.dart';
import '../../controller/login_controller.dart';
import '../widgets/loader.dart';
import '/constants/string.dart';
import '/constants/style.dart';
import '/ui/widgets/submit_button.dart';
import 'package:get/get.dart';
import '../../constants/color.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(MyStrings.signIn, style: MyStyle.appBarText),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 150),
              // InputField('Enter email'),
              // InputField('Enter password', isPassword: true),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: const InputDecoration(
                    hintText: MyStrings.enterEmail,
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                      borderSide: BorderSide(color: MyColors.primary),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                  onChanged: (value) {
                    _loginController.email.value = value;
                  },
                ),
              ),

              // InputField('Enter password',
              //     //controller: _passwordController,
              //     isPassword: true),

              Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                  ),
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: MyStrings.enterPassword,
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30.0),
                      ),
                      borderSide: BorderSide(color: MyColors.primary),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  ),
                  onChanged: (value) {
                    _loginController.password.value = value;
                  },
                ),
              ),

              Obx(
                () => _loginController.isLoading.value
                    ? CommomLoader()
                    : SubmitButton(
                        title: MyStrings.signIn,
                        onPressed: () {
                          _loginController.doLogin();
                        },
                      ),
              ),
              const SizedBox(height: 20),
              SubmitButton(
                title: 'Forget password?',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  
}
