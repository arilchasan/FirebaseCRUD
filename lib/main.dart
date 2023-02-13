import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/firebase_option.dart';
import 'package:firebase_crud/hompage.dart';
import 'package:firebase_crud/login/google.dart';
import 'package:firebase_crud/login/login.dart';
import 'package:firebase_crud/push/push.dart';
import 'package:firebase_crud/settings.dart';
import 'package:firebase_crud/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //
    return ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        builder: (context, child) {
          // final themeProvider = Provider.of<GoogleSignInProvider>(context);
          final loginprovider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              // theme: themeProvider.theme,
              home: LoginPage());
        });
  }
}
