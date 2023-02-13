import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider with ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;
      notifyListeners();

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}

class LogInwidget extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Profile"),
            SizedBox(
              height: 10,
            ),
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                  'https://avatars.dicebear.com/api/avataaars/nama.png'),
            ),
            SizedBox(
              height: 10,
            ),
            Text('Email: ${user.displayName}'),
            Text('Email: ${user.email}'),
          ],
        ),
      ),
    );
  }
}
