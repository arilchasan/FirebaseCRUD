import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud/login/login.dart';
import 'package:firebase_crud/login/screen.dart';
import 'package:firebase_crud/profile.dart';
import 'package:firebase_crud/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in/widgets.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool status2 = false;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        children: [
          ListView(
            children: [
              
              ListTile(
                title: Text(
                  'Ganti Tema ',
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FlutterSwitch(
                      width: 50,
                      height: 30,
                      activeColor: Colors.green,
                      inactiveColor: Color.fromARGB(255, 94, 89, 89),
                      value: status2,
                      onToggle: (val) {
                        themeProvider.toggleTheme();
                        setState(() {
                          status2 = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                height: 1,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (FirebaseAuth.instance.currentUser != null) {
                    // Sign out of Google and Firebase authentication.
                    await GoogleSignIn().signOut();
                    await FirebaseAuth.instance.signOut();

                    // Navigate back to the login page.
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  }
                },
                child: Text('Log Out'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
