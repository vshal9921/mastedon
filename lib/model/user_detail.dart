class UserDetail {
  int createdAt;
  String email;
  String userHandle;
  String userImage;
  String name;
  String userRefId;

  UserDetail(
      {this.createdAt = 0,
      this.email = "",
      this.name = "",
      this.userImage = "",
      this.userHandle = "", 
      this.userRefId = ""
      });
}
