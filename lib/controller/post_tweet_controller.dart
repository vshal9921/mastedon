import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  String imageStoreUrl = '';

  Future<void> postTweet() async {

    if(tweetText.value.isEmpty && imageStoreUrl.isEmpty){
      Get.snackbar(MyStrings.error, MyStrings.contentNotEmpty);
      return;
    }

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
        MyFirestoreConstants.mediaType: 'image',
        MyFirestoreConstants.mediaUrl: imageStoreUrl,
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

      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference refImagesDir = referenceRoot.child(MyFirestoreConstants.images);
      Reference refImageToUpload = refImagesDir.child(DateTime.now().millisecondsSinceEpoch.toString());

      try{
        await refImageToUpload.putFile(File(image.path));
        imageStoreUrl = await refImageToUpload.getDownloadURL();
        UiUtil.debugPrint('image store url is $imageStoreUrl');
      }
      catch(e){
        UiUtil.debugPrint(e.toString());
        Get.snackbar(MyStrings.error, e.toString());
      }
    }
  }
}
