import 'package:flutter/material.dart';
import '/constants/color.dart';
import '/constants/routes.dart';
import '/constants/string.dart';
import '/constants/style.dart';
import '/ui/widgets/submit_button.dart';
import '/utils/shared_pref.dart';
import '/utils/ui_util.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/firestore_constants.dart';

class Register extends StatelessWidget {
  Register({super.key});

  late String email;
  late String password;
  late String name;
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          MyStrings.signUp,
          style: MyStyle.appBarText,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(child: _body(context)),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
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
              decoration: const InputDecoration(
                hintText: MyStrings.enterName,
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
                name = value;
              },
            ),
          ),


          // InputField(
          //   'Name',
          //   //controller: _nameController
          // ),

          // InputField('Enter email',
          //     //controller: _emailController,
          //     isEmail: true),
          // email box

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

          // InputField('Confirm password',
          //     //controller: _confirmController,
          //     isPassword: true),

          SubmitButton(title: MyStrings.signUp, onPressed: registerUser),

          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              const Text(
                MyStrings.accountAlready,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(MyRoutes.login);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                  child: Text(
                    MyStrings.logIn,
                    style: TextStyle(
                      fontSize: 14,
                      color: MyColors.primary,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              )
            ],
          ),

          // const Divider(height: 30),
          // const SizedBox(height: 30),
          // GoogleLoginButton(
          //   loginCallback: widget.loginCallback,
          //   loader: loader,
          // ),
          // const SizedBox(height: 30),
        ],
      ),
    );
  }

  void registerUser() async {
    // close keyboard
    //check validations
    // Goto Home

    UiUtil.closeKeyBoard();

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      String? userEmail =  userCredential.user?.email;
      String userHandle = '';

      if (userEmail != null) {

       UiUtil.debugPrint(userEmail);
       userHandle = userEmail.substring(0, userEmail.indexOf('@'));
       UiUtil.debugPrint('userhandle = $userHandle');

        await SharedPref.setString(SharedPref.email, userEmail);
        await SharedPref.setString(SharedPref.userHandle, userHandle);
        await SharedPref.setString(SharedPref.name, name);

        await _fireStore.collection(MyFirestoreConstants.userTable).add({
          MyFirestoreConstants.email: userEmail,
          MyFirestoreConstants.userHandle: userHandle,
          MyFirestoreConstants.name: name,
          MyFirestoreConstants.createdAt: DateTime.now().microsecondsSinceEpoch,
        });

        Get.offAllNamed(MyRoutes.home);
      } else {
        Get.snackbar(MyStrings.error, MyStrings.errorLogin);
      }
    } catch (e) {
      UiUtil.debugPrint(e);
      Get.snackbar(MyStrings.firebaseError, MyStrings.errorLogin);
    }
  }
}
