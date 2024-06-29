import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../constants/routes.dart';
import '../constants/string.dart';
import '../utils/shared_pref.dart';
import '../utils/ui_util.dart';

class LoginController extends GetxController{

  var isLoading = false.obs;
  var email = "".obs;
  var password = "".obs;
  final _auth = FirebaseAuth.instance;

  void doLogin() async {

    UiUtil.closeKeyBoard();
    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2));

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email.value, password: password.value);

      if (userCredential.user!.email != null) {
        UiUtil.debugPrint(userCredential.user?.email);
        await SharedPref.setString(
            SharedPref.email, userCredential.user?.email ?? "");
        Get.offAllNamed(MyRoutes.home);
      } else {
        Get.snackbar(MyStrings.error, MyStrings.errorLogin);
      }
      isLoading.value = false;
    } catch (e) {
      UiUtil.debugPrint(e);
      Get.snackbar(MyStrings.firebaseError, e.toString());
      isLoading.value = false;
    }
  }

}