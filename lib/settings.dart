import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/login/google.dart';
import 'package:firebase_crud/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in/widgets.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      // body: Row(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     StreamBuilder(
      //       stream: FirebaseAuth.instance.authStateChanges(),
      //       builder: (context, snapshot) {
      //         if (snapshot.connectionState == ConnectionState.waiting) {
      //           return Center(child: CircularProgressIndicator());
      //         } else if (snapshot.hasData) {
      //           return LogInwidget();
      //         } else if (snapshot.hasError) {
      //           return Center(child: Text("Error"));
      //         } else {
      //           return LoginPage();
      //         }
      //       },
      //     ),
      //     Container(
      //         child: ElevatedButton(
      //             child: Text("Logout"),
      //             onPressed: () {
      //               final loginprovider = Provider.of<GoogleSignInProvider>(
      //                   context,
      //                   listen: false);
      //               loginprovider.logout();
      //             }))
      //   ],
      // ),
    );
  }
}
