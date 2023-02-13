import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: signinwithgoogle(), 
          child: Text("Sign In with Google"),
      ),
    ));
  }
}

signinwithgoogle() async {
  GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
  
  GoogleSignInAuthentication? googleAuth = await googleuser!.authentication;

  AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  UserCredential user = await FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());

  print(user.user!.displayName);
}
