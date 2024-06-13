import 'package:flutter/material.dart';
import 'package:mastedon/utils/validation_mixin.dart';
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
      body: SingleChildScrollView(
        // child: _body(context),
        child: RegisterForm(),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> with ValidationMixin {
  late String? email;
  late String? password;
  late String? name;
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.name,
                style: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                ),
                decoration: MyStyle.registerForm(hintText: MyStrings.name),
                onFieldSubmitted: (value) {
                },
                onSaved: (value) {
                  name = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return MyStrings.enterName;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 25.0,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.normal,
                ),
                decoration:
                    MyStyle.registerForm(hintText: MyStrings.enterEmail),
                onFieldSubmitted: (value) {
                },
                onSaved: (value) {
                  email = value;
                },
                validator: (value) {
                  return isEmailValid(value!) ? null : MyStrings.enterEmail;
                },
              ),
              const SizedBox(
                height: 25.0,
              ),
              TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  style: const TextStyle(
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal,
                  ),
                  decoration:
                      MyStyle.registerForm(hintText: MyStrings.enterPassword),
                  onFieldSubmitted: (value) {
                  },
                  onSaved: (value) {
                    password = value;
                  },
                  validator: (value) {
                    return isPasswordValid(value!)
                        ? null
                        : MyStrings.enterPassword;
                  }),
              SubmitButton(
                  title: MyStrings.signUp,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      registerUser();
                    }
                  }),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 2, vertical: 10),
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
            ],
          ),
        ));
  }

  void registerUser() async {
    // close keyboard
    //check validations
    // Goto Home

    final isValid = _formKey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _formKey.currentState?.save();

    UiUtil.closeKeyBoard();

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email!, password: password!);

      String? userEmail = userCredential.user?.email;
      String userHandle = '';

      if (userEmail != null) {
        UiUtil.debugPrint(userEmail);
        userHandle = userEmail.substring(0, userEmail.indexOf('@'));
        UiUtil.debugPrint('userhandle = $userHandle');

        await SharedPref.setString(SharedPref.email, userEmail);
        await SharedPref.setString(SharedPref.userHandle, userHandle);
        await SharedPref.setString(SharedPref.name, name!);

        await _fireStore.collection(MyFirestoreConstants.userTable).add({
          MyFirestoreConstants.email: userEmail,
          MyFirestoreConstants.userHandle: userHandle,
          MyFirestoreConstants.name: name,
          MyFirestoreConstants.userImage: MyStrings.defaultPic,
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
