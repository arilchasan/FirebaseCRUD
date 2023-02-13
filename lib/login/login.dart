import 'package:firebase_crud/hompage.dart';
import 'package:firebase_crud/login/google.dart';
import 'package:firebase_crud/my_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final kontak = MyFirebase.contactsCollection.snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
        ),
        icon: FaIcon(
          FontAwesomeIcons.google,
          color: Colors.blue,
        ),
        onPressed: () {
          final loginprovider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          loginprovider.googleLogin();
        },
        label: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Lanjutkan dengan Google",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
