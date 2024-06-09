import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/constants/firestore_constants.dart';
import '/constants/string.dart';
import '/utils/ui_util.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/shared_pref.dart';

class PostTweetController extends GetxController {
  var isLoading = false.obs;
  var tweetText = ''.obs;
  final ImagePicker _picker = ImagePicker();
  Rx<XFile?> selectedFile = Rx<XFile?>(null);

  Future<void> postTweet() async {
    isLoading.value = true;

    try {
      FirebaseFirestore.instance
          .collection(MyFirestoreConstants.tweetsTable)
          .add({
        MyFirestoreConstants.email:
            SharedPref.getString(SharedPref.email) ?? '',
        MyFirestoreConstants.name: SharedPref.getString(SharedPref.name) ?? '',
        MyFirestoreConstants.createdAt: DateTime.now().microsecondsSinceEpoch,
        MyFirestoreConstants.userHandle:
            SharedPref.getString(SharedPref.userHandle) ?? '',
        MyFirestoreConstants.userImage: MyStrings.defaultPic,
        MyFirestoreConstants.mediaType: '',
        MyFirestoreConstants.mediaUrl: '',
        MyFirestoreConstants.likes: Random().nextInt(50),
        MyFirestoreConstants.numComments: Random().nextInt(35),
        MyFirestoreConstants.numRetweets: Random().nextInt(20),
        MyFirestoreConstants.text: tweetText.value,
      });

      tweetText.value = '';
      selectedFile.value = null;
      UiUtil.debugPrint(MyStrings.tweetPostedSuccess);
      Get.snackbar(MyStrings.success, MyStrings.tweetPostedSuccess);
    } catch (e) {
      UiUtil.debugPrint(e.toString());
      Get.snackbar(MyStrings.error, e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void setText(String value) {
    tweetText.value = value;
  }

  void performImagePick() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if(image != null){
      selectedFile.value = image;
      UiUtil.debugPrint('image path = ${image.path}');
    }
  }
}
