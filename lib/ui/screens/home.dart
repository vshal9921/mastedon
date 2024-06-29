import 'package:flutter/material.dart';
import '/constants/color.dart';
import '/constants/routes.dart';
import '/controller/home_controller.dart';
import '/ui/widgets/loader.dart';
import '/ui/widgets/sidebar_menu.dart';
import '/ui/widgets/tweet_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //HomeController homeController = Get.put(HomeController());

  void checkCurrentUser() async {
    _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        initState: (_) {},
        builder: (homeController) {
          // API call
          homeController.getTweets();
          homeController.getUserProfile();

          return Scaffold(
            key: _scaffoldKey,
            floatingActionButton: _floatingActionButton(context),
            backgroundColor: MyColors.mystic,
            drawer: SidebarMenu(),
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: MyColors.primary,
                ),
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              title: const Icon(
                FontAwesomeIcons.mastodon,
                size: 40.0,
                color: MyColors.primary,
              ),
              //Image.asset('images/icon-480.png', height: 40),
              centerTitle: true,
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
                child: Obx(() =>
                  homeController.isLoading.value ? CommomLoader() : FeedBody(),
            )),
          );
        });
  }

  Widget _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        // goto create tweet page
        Get.toNamed(MyRoutes.postTweetScreen);
      },
      backgroundColor: MyColors.primary,
      shape: const CircleBorder(),
      child: const Icon(
        FontAwesomeIcons.mastodon,
        size: 25,
        color: MyColors.white,
      ),
    );
  }
}

class FeedBody extends StatelessWidget {
  FeedBody({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();

    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: MyColors.white,
      ),
      child: RefreshIndicator(
        color: MyColors.primary,
        onRefresh: homeController.getTweets,
        child: Obx(
          () => ListView.builder(
              itemCount: homeController.tweetList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: TweetCard(homeController.tweetList[index]),
                  onTap: () {
                    Get.toNamed(MyRoutes.feedDetail, parameters: {
                      "tweetId": homeController.tweetList[index].tweetId
                    });
                  },
                );
              }),
        ),
      ),
    );
  }
}
