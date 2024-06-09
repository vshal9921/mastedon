import 'package:cloud_firestore/cloud_firestore.dart';
import '/constants/firestore_constants.dart';
import '/constants/string.dart';
import '/model/tweets.dart';
import '/model/user_detail.dart';
import '/utils/shared_pref.dart';
import '/utils/ui_util.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeController extends GetxController {

  // static HomeController instance = Get.find();

  final _auth = FirebaseAuth.instance;
  var isLoading = false.obs;
  var tweetList = <Tweet>[].obs;
  var userDetail = UserDetail().obs;

  @override
  void onInit(){
    super.onInit();

    getCurrentUser();
    getTweets();
  }

  Future<void> getTweets() async {

    isLoading.value = true;

    try{
      QuerySnapshot tweets = await FirebaseFirestore.instance.collection(MyFirestoreConstants.tweetsTable).orderBy(MyFirestoreConstants.createdAt).get();
      tweetList.clear();
      for(var tweet in tweets.docs){
        
        tweetList.add(Tweet(createdAt: tweet[MyFirestoreConstants.createdAt], text: tweet[MyFirestoreConstants.text], likes: tweet[MyFirestoreConstants.likes],
         numComments: tweet[MyFirestoreConstants.numComments], numRetweets: tweet[MyFirestoreConstants.numRetweets], 
         mediaTypes: tweet[MyFirestoreConstants.mediaType], mediaUrl: tweet[MyFirestoreConstants.mediaUrl],
         name: tweet[MyFirestoreConstants.name], email: tweet[MyFirestoreConstants.email], 
         userHandle: tweet[MyFirestoreConstants.userHandle], userImage: tweet[MyFirestoreConstants.userImage],
         tweetId: tweet.reference.id));
      }
    }
    catch(e){      
      Get.snackbar(MyStrings.error, e.toString());
      UiUtil.debugPrint(e);
    }
    finally{
      isLoading.value = false;
    }
  }

  Future<void> getUserProfile() async {

    try{
      QuerySnapshot userDetailSnapshot = await FirebaseFirestore.instance.collection(MyFirestoreConstants.userTable).where(MyFirestoreConstants.email, isEqualTo: SharedPref.getString(SharedPref.email)).get() ;

      if(userDetailSnapshot.docs.isNotEmpty){

        QueryDocumentSnapshot userDetailMap = userDetailSnapshot.docs.first;

        userDetail.value = UserDetail(
          createdAt: userDetailMap[MyFirestoreConstants.createdAt], name: userDetailMap[MyFirestoreConstants.name],
           email: userDetailMap[MyFirestoreConstants.email], userHandle: userDetailMap[MyFirestoreConstants.userHandle], 
           userImage: userDetailMap[MyFirestoreConstants.userImage], userRefId: userDetailMap.reference.id
        );  

        await SharedPref.setString(SharedPref.name, userDetail.value.name);
        await  SharedPref.setString(SharedPref.userHandle, userDetail.value.userHandle);
        await  SharedPref.setString(SharedPref.userImage, userDetail.value.userImage);     
      }      
    }
    catch(e){
      Get.snackbar(MyStrings.error, e.toString());
      UiUtil.debugPrint(e);
    }
  }

  void getCurrentUser() async{
    _auth.currentUser;
  }

}