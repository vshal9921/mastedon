import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '/constants/color.dart';
import '/constants/routes.dart';
import '/constants/string.dart';
import '/constants/style.dart';
import '/ui/widgets/custom_widgets.dart';
import '/utils/shared_pref.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SidebarMenu extends StatefulWidget {
  
  SidebarMenu({Key? key, this.scaffoldKey}) : super(key: key);

  final GlobalKey<ScaffoldState>? scaffoldKey;
  final _auth = FirebaseAuth.instance;

  @override
  _SidebarMenuState createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {

  ListTile _menuListRowButton(String title,
      {Function? onPressed, IconData? icon, bool isEnable = false}) {
    return ListTile(
      onTap: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      leading: icon == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(top: 5),
              child: customIcon(
                context,
                icon: icon,
                size: 20,
                iconColor: isEnable ? MyColors.secondary : MyColors.darkGrey,
              ),
            ),
      title: customText(
        title,
        style: TextStyle(
          fontSize: 18,
          color: isEnable ? MyColors.secondary : MyColors.darkGrey,
          fontWeight: FontWeight.w900
        ),
      ),
    );
  }

  Positioned _footer() {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Column(
        children: <Widget>[
          const Divider(height: 0),
          Row(
            children: <Widget>[
              const SizedBox(
                width: 10,
                height: 45,
              ),
              const Icon(FontAwesomeIcons.lightbulb, size: 25,
              color: MyColors.primary,),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // 
                },
                child: const Icon(FontAwesomeIcons.qrcode,
                size: 25, 
                color: MyColors.primary,) 
                // Image.asset(
                //   "images/qr.png",
                //   height: 25,
                // ),
              ),
              const SizedBox(
                width: 0,
                height: 45,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // void _navigateTo(String path) {
  //   Navigator.pop(context);
  //   Navigator.of(context).pushNamed('/$path');
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 45),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  const SizedBox(height:  20.0),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: Image.network(SharedPref.getString(SharedPref.userImage) ?? MyStrings.defaultPic,
                        height: 70.0,
                        width: 70.0,
                        fit: BoxFit.cover,),
                    ),
                  ),
                  const SizedBox(height:  20.0),
                  Center(
                    child: Text(SharedPref.getString(SharedPref.name) ?? "Hello",
                    style: MyStyle.profileText,),
                  ),
                  Center(
                    child: Text('@${SharedPref.getString(SharedPref.userHandle) ?? "Hello"}',
                    style: MyStyle.tweetHandle),
                  ),
                  const Divider(),
                  _menuListRowButton('Profile',
                      icon: FontAwesomeIcons.user, isEnable: true, onPressed: () {
                    Get.toNamed(MyRoutes.profile);
                  }),
                  _menuListRowButton(
                    'Bookmark',
                    icon: FontAwesomeIcons.bookmark,
                    isEnable: true,
                    onPressed: () {
                      // goto bookmark
                      Get.snackbar(MyStrings.comingSoon, MyStrings.updates);
                    },
                  ),
                  _menuListRowButton('Lists', icon: FontAwesomeIcons.list, 
                  onPressed: (){
                    Get.snackbar(MyStrings.comingSoon, MyStrings.updates);
                  }),
                  _menuListRowButton('Moments', icon: FontAwesomeIcons.boltLightning,
                  onPressed: (){
                    Get.snackbar(MyStrings.comingSoon, MyStrings.updates);
                  }),
                  const Divider(),
                  _menuListRowButton('Settings and privacy', isEnable: true,
                      onPressed: () {
                        Get.toNamed(MyRoutes.webviewTerms,);
                  }),
                  _menuListRowButton('Help Center', isEnable: true, 
                  onPressed: (){
                    Get.toNamed(MyRoutes.webviewHelp,);
                  }),
                  const Divider(),
                  _menuListRowButton('Logout',
                      icon: null, onPressed: _logOut, isEnable: true),
                ],
              ),
            ),
            _footer()
          ],
        ),
      ),
    );
  }

  void _logOut() async {
    await widget._auth.signOut();
    Get.offAllNamed(MyRoutes.register);
    SharedPref.clear();
  }
}
