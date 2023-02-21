import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/firebase_option.dart';
import 'package:firebase_crud/hompage.dart';

import 'package:firebase_crud/profile.dart';

import 'package:firebase_crud/login/login.dart';
import 'package:firebase_crud/login/screen.dart';
import 'package:firebase_crud/push/push.dart';
import 'package:firebase_crud/settings.dart';

import 'package:firebase_crud/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('fcmToken: $fcmToken');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //
    return ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, child) {

              final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(   
            debugShowCheckedModeBanner: false,       
              title: 'Flutter Demo',
              theme: themeProvider.theme,
              home: const LoginScreen());
        });
  }
}
