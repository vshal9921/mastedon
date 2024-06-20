import 'dart:io';

import 'package:flutter/material.dart';
import '/constants/color.dart';
import '/constants/string.dart';
import '/constants/style.dart';
import '/controller/post_tweet_controller.dart';
import '/ui/widgets/loader.dart';
import '/utils/ui_util.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class PostTweetScreen extends StatelessWidget {
  final PostTweetController postTweetController = Get.put(PostTweetController());

  PostTweetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MyStrings.postATweet,
          style: MyStyle.tweetText.copyWith(fontSize: 20.0),
        ),
        //centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Container(
            color: MyColors.background,
            height: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(
              () => TextField(
                maxLength: 280,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: MyStrings.whatsHappening,
                  border: OutlineInputBorder(),
                ),
                controller: TextEditingController(
                    text: postTweetController.tweetText.value)
                  ..selection = TextSelection.fromPosition(TextPosition(
                      offset: postTweetController.tweetText.value.length)),
                onChanged: postTweetController.setText,
              ),
            ),

            Obx(
              () => postTweetController.selectedFile.value != null ?
              SizedBox(
                height: 300.0,
                width: double.infinity,
                child: Image.file(File(postTweetController.selectedFile.value!.path)))
                : Container()
          
            ),
            
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    postTweetController.performImagePick();
                  },
                  icon: const Icon(
                    FontAwesomeIcons.image,
                    size: 25.0,
                    color: MyColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Obx(
              () => postTweetController.isLoading.value
                  ? CommomLoader()
                  : ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(MyColors.primary),
                      ),
                      onPressed: () {
                        // Handle the post tweet logic here
                        UiUtil.closeKeyBoard();
                        postTweetController.postTweet();
                      },
                      child: Text(
                        MyStrings.postTweet,
                        style: MyStyle.postButton,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}


