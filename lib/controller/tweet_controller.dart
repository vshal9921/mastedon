import 'package:cloud_firestore/cloud_firestore.dart';
import '/constants/firestore_constants.dart';
import '/constants/string.dart';
import '/model/tweets.dart';
import '/utils/ui_util.dart';
import 'package:get/get.dart';

class TweetController extends GetxController {
  var isLoading = false;
  var isLiked = false.obs;
  Tweet? singleTweet;

  Future<void> getTweetById() async {
    isLoading = true;

    try {
      String tweetId = Get.parameters['tweetId'].toString();
      UiUtil.debugPrint('tweetId is $tweetId');

      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(MyFirestoreConstants.tweetsTable)
          .doc(tweetId)
          .get();

      if (documentSnapshot.exists) {
        singleTweet = Tweet.fromDocument(documentSnapshot);
      } else {
        Get.snackbar(MyStrings.error, 'Unable to get data');
      }
    } catch (e) {
      Get.snackbar(MyStrings.error, e.toString());
      UiUtil.debugPrint(e);
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> performLike() async {
    if (singleTweet == null) {
      Get.snackbar(MyStrings.error, MyStrings.tweetNotFound);
    } else {
      try {
        isLiked.value != isLiked.value;
        int currentLikes = singleTweet?.likes ?? 0;

        if (isLiked.value) {
          singleTweet?.likes = currentLikes - 1;
        } else {
          singleTweet?.likes = currentLikes + 1;
        }
      } catch (e) {
        Get.snackbar(MyStrings.error, e.toString());
        UiUtil.debugPrint(e);
      } finally {
        update();
      }
    }
  }
}
