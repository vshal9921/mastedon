import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/constants/color.dart';
import '/constants/string.dart';
import '/constants/style.dart';
import '/controller/tweet_controller.dart';
import '/ui/widgets/loader.dart';
import '/ui/widgets/video_player_widget.dart';
import '/utils/ui_util.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class FeedDetail extends StatelessWidget {
  FeedDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TweetController tweetController = Get.put(TweetController());
    tweetController.getTweetById();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          MyStrings.post,
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
      body: GetBuilder<TweetController>(builder: (tweetController) {
        return tweetController.isLoading
            ? CommomLoader()
            : FeedDetailBody(tweetController);
      }),
    );
  }
}

class FeedDetailBody extends StatelessWidget {
  final TweetController tweetController;

  FeedDetailBody(
    this.tweetController, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UiUtil.debugPrint('singletweet - ${tweetController.singleTweet?.text}');

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 27.0,
                backgroundImage:
                    NetworkImage(tweetController.singleTweet?.userImage ?? ""),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tweetController.singleTweet?.name ?? "",
                      style: MyStyle.tweetText,
                    ),
                    Text(
                      '@${tweetController.singleTweet?.userHandle}',
                      style: MyStyle.tweetHandle,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
            child: Text(
            tweetController.singleTweet?.text ?? "",
            style: MyStyle.tweetText.copyWith(
              fontSize: 20.0,
            ),
          ),
          ),
          Visibility(
            visible: tweetController.singleTweet?.mediaTypes == 'image',
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(50.0),
                ),
              ),
              child: CachedNetworkImage(
                imageUrl: tweetController.singleTweet?.mediaUrl ?? "",
              ),
            ),
          ),
          Visibility(
            visible: tweetController.singleTweet?.mediaTypes == 'video',
            child: VideoPlayerWidget(videoUrl: tweetController.singleTweet?.mediaUrl ?? ""),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.chat_bubble_outline,
                      color: MyColors.iconColor,
                      size: 20.0,
                    ),
                    onPressed: () {},
                  ),
                  Text(
                    '${tweetController.singleTweet?.numComments}',
                    style: MyStyle.tweetHandle,
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.repeat,
                      color: MyColors.iconColor,
                      size: 20.0,
                    ),
                    onPressed: () {},
                  ),
                  Text(
                    '${tweetController.singleTweet?.numRetweets}',
                    style: MyStyle.tweetHandle,
                  )
                ],
              ),
              Row(
                children: [
                  Obx(()=>
                    IconButton(
                        icon: tweetController.isLiked.value ? 
                         Icon(
                          Icons.favorite,
                          color: MyColors.ceriseRed,
                          size: 20.0,
                        ) : const Icon(
                          Icons.favorite_border,
                          color:MyColors.iconColor,
                          size: 20.0,
                        ),
                        onPressed: () {
                          tweetController.performLike();
                        },
                      ),
                  ),
                  Text(
                      '${tweetController.singleTweet?.likes}',
                      style: MyStyle.tweetHandle,
                    ),
                ],
              ),
              IconButton(
                icon: const Icon(
                  Icons.share_outlined,
                  color: MyColors.iconColor,
                  size: 20.0,
                ),
                onPressed: () {
                  Share.share(MyStrings.shareUrl);
                },
              ),
            ],
          ),
          const Divider(
            color: MyColors.background,
            height: 1.0,
          )
        ],
      ),
    );
  }
}
