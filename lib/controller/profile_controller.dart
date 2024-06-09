import '/utils/shared_pref.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{

  var name = SharedPref.getString(SharedPref.name).obs;

  @override
  void onInit() {
    super.onInit();

    
  }
}