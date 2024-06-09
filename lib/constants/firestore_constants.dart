class MyFirestoreConstants{

  MyFirestoreConstants._();
  
  // tables
  static const String userTable = 'users';
  static const String tweetsTable = 'tweets';

  // fields
  static const String email = 'email';
  static const String name = 'name';
  static const String createdAt = 'createdAt';

  // tweets
  static const String text = 'text';
  static const String user = 'user';
  static const String likes = 'likes';
  static const String mediaType = 'mediaType';
  static const String mediaUrl = 'mediaUrl';
  static const String numComments = 'numComments';
  static const String numRetweets = 'numRetweets';
  static const String userHandle = 'userHandle';
  static const String userImage = 'userImage';
}