import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/constants/routes.dart';
import '/constants/string.dart';
import '/constants/style.dart';
import '/ui/widgets/submit_button.dart';
import '/utils/ui_util.dart';
import 'package:get/get.dart';
import '../../constants/color.dart';
import '../../utils/shared_pref.dart';

class Login extends StatelessWidget {
  Login({super.key});

  late String email;
  late String password;
  final _auth = FirebaseAuth.instance;

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
                    email = value;
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
                    password = value;
                  },
                ),
              ),

              SubmitButton(
                title: MyStrings.signIn,
                onPressed: () {
                  doLogin();
                },
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

  void doLogin() async{

    UiUtil.closeKeyBoard();

    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      
      if(userCredential.user!.email != null){

        UiUtil.debugPrint(userCredential.user?.email);
        await SharedPref.setString(SharedPref.email, userCredential.user?.email ?? "");
        Get.offAllNamed(MyRoutes.home);
      }
      else {
        Get.snackbar(MyStrings.error, MyStrings.errorLogin);
      }
    }
    catch(e){
      UiUtil.debugPrint(e);
      Get.snackbar(MyStrings.firebaseError, e.toString());
    }
  }
}
