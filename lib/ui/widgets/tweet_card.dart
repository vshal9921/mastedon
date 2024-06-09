import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '/constants/string.dart';
import '/constants/style.dart';
import '/model/tweets.dart';
import '/utils/ui_util.dart';
import '../../constants/color.dart';
import 'package:share_plus/share_plus.dart';

import 'video_player_widget.dart';

class TweetCard extends StatelessWidget {
  final Tweet tweet;

  TweetCard(this.tweet, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 27.0,
                backgroundImage: NetworkImage(tweet.userImage),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          tweet.name,
                          style: MyStyle.tweetText
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 5),
                        Text(
                            '@${tweet.userHandle} · ${UiUtil.convertTStoTime(tweet.createdAt)}',
                            style: MyStyle.tweetHandle),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                      child: Text(tweet.text, style: MyStyle.tweetText),
                    ),
                    Visibility(
                      visible: tweet.mediaTypes == 'image',
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: tweet.mediaUrl,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: tweet.mediaTypes == 'video',
                      child: VideoPlayerWidget(videoUrl: tweet.mediaUrl),
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
                              '${tweet.numComments}',
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
                              '${tweet.numRetweets}',
                              style: MyStyle.tweetHandle,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.favorite_border,
                                color: MyColors.iconColor,
                                size: 20.0,
                              ),
                              onPressed: () {},
                            ),
                            Text(
                              '${tweet.likes}',
                              style: MyStyle.tweetHandle,
                            )
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
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: MyColors.background,
          height: 1.0,
        )
      ],
    );
  }
}
