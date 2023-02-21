import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/hompage.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
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
            onPressed: () async {
              if (FirebaseAuth.instance.currentUser == null) {
                GoogleSignInAccount? account = await GoogleSignIn().signIn();
                await Firebase.initializeApp();

                if (account != null) {
                  GoogleSignInAuthentication auth =
                      await account.authentication;
                  OAuthCredential credential = GoogleAuthProvider.credential(
                    accessToken: auth.accessToken,
                    idToken: auth.idToken,
                  );
                  await FirebaseAuth.instance.signInWithCredential(credential);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                } else {
                  GoogleSignIn().signOut();
                  FirebaseAuth.instance.signOut();
                }
              }
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
          ElevatedButton.icon(
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
            onPressed: () async {
              if (FirebaseAuth.instance.currentUser != null) {
                // Sign out of Google and Firebase authentication.
                await GoogleSignIn().signOut();
                await FirebaseAuth.instance.signOut();

                // Navigate back to the login page.
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }
            },
            label: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Logout",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
