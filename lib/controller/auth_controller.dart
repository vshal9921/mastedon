import 'package:firebase_auth/firebase_auth.dart';
import '/constants/routes.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAllNamed(MyRoutes.register);
    } else {
      Get.offAllNamed(MyRoutes.home);
    }
  }

  // void signIn(String email, String password) async {
  //   try {
  //     await auth.signInWithEmailAndPassword(email: email, password: password);
  //   } catch (e) {
  //     Get.snackbar("Sign In Failed", e.toString());
  //   }
  // }

  // void signOut() async {
  //   await auth.signOut();
  // }
}
