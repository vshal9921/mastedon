import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/firestore_constants.dart';

class Tweet {
  int createdAt;
  String text;
  int likes;
  String mediaTypes;
  String mediaUrl;
  int numComments;
  int numRetweets;
  String email;
  String userHandle;
  String userImage;
  String name;
  String tweetId;

  Tweet(
      {this.createdAt = 0,
      this.text = "",
      this.likes = 0,
      this.mediaTypes = "",
      this.mediaUrl = "",
      this.numComments = 0,
      this.numRetweets = 0,
      this.email = "",
      this.name = "",
      this.userImage = "",
      this.userHandle = "",
      this.tweetId = ""});

  factory Tweet.fromDocument(DocumentSnapshot doc) {
    return Tweet(
      createdAt: doc[MyFirestoreConstants.createdAt],
      email: doc[MyFirestoreConstants.email],
      likes: doc[MyFirestoreConstants.likes],
      mediaTypes: doc[MyFirestoreConstants.mediaType],
      mediaUrl: doc[MyFirestoreConstants.mediaUrl],
      name: doc[MyFirestoreConstants.name],
      numComments: doc[MyFirestoreConstants.numComments],
      numRetweets: doc[MyFirestoreConstants.numRetweets],
      text: doc[MyFirestoreConstants.text],
      userHandle: doc[MyFirestoreConstants.userHandle],
      userImage: doc[MyFirestoreConstants.userImage],
    );
  }
}
