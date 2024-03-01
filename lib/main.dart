import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:ibc_telecom/provider/home_provider.dart';
import 'package:ibc_telecom/shared_pref/preference.dart';
import 'package:ibc_telecom/views/notification/notification_screen.dart';
import 'package:ibc_telecom/views/splash_screen.dart';
import 'package:ibc_telecom/views/theme.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'bottom_bar/tab_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MySharedPreferences.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? fcmToken;

  String? initialMessage;

  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings();

  @override
  void initState() {
    firebaseNotification();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider<BannerProvider>(
          create: (context) => BannerProvider(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: Themes.light,
    
        // themeMode: ThemeMode.system,
        // darkTheme: Themes.dark,
        home: const SplashScreen(),
      ),
    );
  }

  firebaseNotification() async {
    firebaseMessaging.requestPermission(alert: true);
    firebaseMessaging.isAutoInitEnabled;
    var android =
        const AndroidInitializationSettings('@drawable/launch_background');
    var ios = const DarwinInitializationSettings();
    
    var platform = InitializationSettings(android: android, iOS: ios);
    flutterLocalNotificationsPlugin.initialize(platform);
    firebaseMessaging.requestPermission(
       );
    initLocalNotification();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      AppleNotification? appleNotification = message.notification?.apple;

      print('message notification body=====${message.notification?.body}');
      if (notification != null && android != null) {
        showNotification(message.notification);
        print('android not null notification==${message.notification}');
        FirebaseMessaging.instance.getInitialMessage().then((message) {
          if (message != null) {
            print("abc525");
          } else {
            print("abc");
          }
        });
      } else if (notification != null && appleNotification != null) {
        showNotification(message.notification);
      } else {}
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        Get.offAll(NotificationScreen());
      }
    });

    firebaseMessaging.getToken().then((String? token) async {
      if (token == null) {
      } else {
        MySharedPreferences.localStorage
            ?.setString(MySharedPreferences.deviceId, token);
        print("token===$token");
      }
    }).catchError((error) {
      print(error.toString());
    });
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      print('FlutterFire Messaging Example: Getting APNs token...');
      String? token = await FirebaseMessaging.instance.getAPNSToken();
      print('FlutterFire Messaging Example: Got APNs token: $token');
    }
  }

  Future initLocalNotification() async {
    if (Platform.isIOS) {
      // set iOS Local notification.
      var initializationSettingsAndroid =
          const AndroidInitializationSettings('ic_launcher');
      var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: true,
        
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
      );

      final InitializationSettings initializationSettings =
          InitializationSettings(
              android: initializationSettingsAndroid,
              iOS: initializationSettingsDarwin);
      flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
    } else {
      // set Android Local notification.
      var initializationSettingsAndroid =
          const AndroidInitializationSettings('@drawable/launch_background');
      var initializationSettingsIOS = DarwinInitializationSettings(
          onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);

      await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveBackgroundNotificationResponse: (details) {
          _selectNotification(details.payload);
        },
      );
    }
  }

  Future showNotification(RemoteNotification? notification) async {
    var android = const AndroidNotificationDetails(
      'CHANNLEID',
      "CHANNLENAME",
      channelDescription: "channelDescription",
      importance: Importance.max,
      fullScreenIntent: true,
      priority: Priority.high,
      visibility: NotificationVisibility.public,

    );
    
    var iOS = const DarwinNotificationDetails( sound: 'default',);
    var platform = NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(DateTime.now().second,
        notification?.title, notification?.body, platform);
  }

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  
    print("Handling a background message==$message");
      Get.offAll(NotificationScreen());
  }

  Future _onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    print("receive==$payload,== $body");
      Get.offAll(NotificationScreen());
  }

  Future _selectNotification(String? payload) async {
    return    Get.offAll(NotificationScreen());
  }

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
      Get.offAll(NotificationScreen());
  }

}
