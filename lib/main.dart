import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'binding/controller_binding.dart';
import 'constants/routes.dart';
import 'constants/string.dart';
import 'ui/screens/feed_detail.dart';
import 'ui/screens/home.dart';
import 'ui/screens/post_tweet_screen.dart';
import 'ui/screens/profile_screen.dart';
import 'ui/screens/register.dart';
import 'ui/widgets/web_widget.dart';
import 'utils/shared_pref.dart';
import 'utils/ui_util.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'ui/screens/login.dart';
import 'ui/widgets/auth_check.dart';
import 'firebase_options.dart';
import 'package:rxdart/rxdart.dart';

final _messageStreamController = BehaviorSubject<RemoteMessage>();

late AndroidNotificationChannel channel;
bool isFlutterLocalNotificationsInitialized = false;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final messaging = FirebaseMessaging.instance;

  String? token = await messaging.getToken();
  UiUtil.debugPrint('Push token = $token');

  // Web/iOS app users need to grant permission to receive messages
  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (kDebugMode) {
    print('Permission granted: ${settings.authorizationStatus}');
  }
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print('Handling a foreground message: ${message.messageId}');
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification?.title}');
      print('Message notification: ${message.notification?.body}');
    }

    _messageStreamController.sink.add(message);
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,      
      initialRoute:  MyRoutes.authCheck,
      getPages: [
        GetPage(name: MyRoutes.authCheck, page: () => const AuthCheck()),
        GetPage(name: MyRoutes.register, page: () => Register()),
        GetPage(name: MyRoutes.login, page: () => Login()),
        GetPage(name: MyRoutes.home, page: () => Home()),
        GetPage(name: MyRoutes.feedDetail, page: () => FeedDetail(), transition: Transition.rightToLeftWithFade),
        GetPage(name: MyRoutes.postTweetScreen, page: () => PostTweetScreen()),
        GetPage(name: MyRoutes.webviewTerms, page: () => WebWidget(webUrl: MyStrings.twitterTermsUrl)),
        GetPage(name: MyRoutes.webviewHelp, page: () => WebWidget(webUrl: MyStrings.twitterHelpUrl)),
        GetPage(name: MyRoutes.profile, page: () => Profile()),
      ],
      initialBinding: ControllerBinding(),
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          // add a proper drawable resource to android, for now using
          // one that already exists in example app.
          icon: MyStrings.mastodonIcon,
        ),
      ),
    );
  }
}


