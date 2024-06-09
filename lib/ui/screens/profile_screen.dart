import 'package:flutter/material.dart';
import '/constants/color.dart';
import '/constants/string.dart';
import '/constants/style.dart';
import '/controller/profile_controller.dart';
import '/utils/shared_pref.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.mystic,
      appBar: AppBar(
        title: Text(
          MyStrings.profile,
          style: MyStyle.tweetText.copyWith(fontSize: 20.0),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Container(
            color: MyColors.background,
            height: 1.0,
          ),
        ),
      ),
      body: SafeArea(
        child: ProfileBody(profileController),
      ),
    );
  }
}

class ProfileBody extends StatelessWidget {

  final ProfileController profileController;

  ProfileBody(this.profileController, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: MyColors.white),
      margin: const EdgeInsets.all(10.0),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20.0,),
          Center(
            child: CircleAvatar(
              radius: 100.0,
              backgroundImage: NetworkImage(
                  SharedPref.getString(SharedPref.userImage) ??
                      MyStrings.defaultPic),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Divider(),
      
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(MyStrings.name, style: MyStyle.tweetText,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                counterText: '', 
                contentPadding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
              ),
              maxLines: 1,
              maxLength: 80,
              onChanged: (newValue){
               profileController.name.value = newValue;
              },
              controller: TextEditingController(text: profileController.name.value)
                  ..selection = TextSelection.fromPosition(TextPosition(offset: profileController.name.value?.length ?? 0)),
            
            ),
          ),
        ],
      ),
    );
  }
}
