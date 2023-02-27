import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/login/screen.dart';
import 'package:firebase_crud/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  bool status2 = false;
  
  @override
  Widget build(BuildContext context) {

    var widthScreen = MediaQuery.of(context).size.width;
    bool IsSmartphone = false;
    if (widthScreen < 550) {
      IsSmartphone = true;
    }

    final themeProvider = Provider.of<ThemeProvider>(context);
    final user = FirebaseAuth.instance.currentUser;
    final account = GoogleSignIn().currentUser;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Profile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: IsSmartphone
            ? potrait(context)
            : OrientationBuilder(
                builder: (context, orientation) {
                  return orientation == Orientation.portrait
                      ? potrait(context)
                      : landscape(context);
                },
              ));
  }
}

//potrait
Widget potrait(BuildContext context) {
  @override
  final themeProvider = Provider.of<ThemeProvider>(context);

  final user = FirebaseAuth.instance.currentUser;
  final account = GoogleSignIn().currentUser;
  return Column(
    children: [
      const SizedBox(height: 20),
      Center(
        child: SizedBox(
          height: 115,
          width: 155,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  "${user?.photoURL}",
                  scale: 0.5,
                ),
              ),
              Positioned(
                right: 20,
                bottom: 0,
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Color(0xFFE0E0E0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () {},
                    child: SvgPicture.asset("assets/icons/profile-camera.svg",
                        color: Colors.black, height: 22, width: 22),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      const SizedBox(height: 20),
      ProfileMenu(
        text: '${user?.displayName}',
        icon: "assets/icons/person.svg",
        press: () {},
      ),
      ProfileMenu(
        text: "${user?.email}",
        icon: "assets/icons/email.svg",
        press: () {},
      ),
      Container(
        width: 360,
        margin: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: Color(0xFFE0E0E0),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          title: Text(
            'Ganti Tema ',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              FlutterSwitch(
                borderRadius: 30,
                width: 50,
                height: 30,
                activeColor: Colors.green,
                inactiveColor: Color.fromARGB(255, 94, 89, 89),
                value: status2,
                onToggle: (val) {
                  themeProvider.toggleTheme();
                  if (status2 == false) {
                    status2 = true;
                  } else {
                    status2 = false;
                  }
                },
              ),
            ],
          ),
        ),
      ),
      TextButton(
        onPressed: () async {
          if (FirebaseAuth.instance.currentUser != null) {
            // Show the confirmation dialog.
            bool confirm = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Logout'),
                  content: Text('Apakah anda yakin ingin logout?'),
                  actions: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    ),
                    TextButton(
                      child: Text('Logout'),
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ],
                );
              },
            );

            // If the user confirmed, sign out of Google and Firebase authentication.
            if (confirm) {
              await GoogleSignIn().signOut();
              await FirebaseAuth.instance.signOut();

              // Navigate back to the login page.
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }
          }
        },
        child: Text(
          'Logout',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      )
    ],
  );
}

//landscape
Widget landscape(BuildContext context) {
  @override
  final themeProvider = Provider.of<ThemeProvider>(context);

  final user = FirebaseAuth.instance.currentUser;
  final account = GoogleSignIn().currentUser;
  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              height: 115,
              width: 155,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      "${user?.photoURL}",
                      scale: 0.5,
                    ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: 0,
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: Color(0xFFE0E0E0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () {},
                        child: SvgPicture.asset(
                            "assets/icons/profile-camera.svg",
                            color: Colors.black,
                            height: 22,
                            width: 22),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          ProfileMenu(
            text: '${user?.displayName}',
            icon: "assets/icons/person.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "${user?.email}",
            icon: "assets/icons/email.svg",
            press: () {},
          ),
          Container(
            width: 800,
            margin: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              title: Text(
                'Ganti Tema ',
                style:
                    TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FlutterSwitch(
                    borderRadius: 30,
                    width: 50,
                    height: 30,
                    activeColor: Colors.green,
                    inactiveColor: Color.fromARGB(255, 94, 89, 89),
                    value: status2,
                    onToggle: (val) {
                      themeProvider.toggleTheme();
                      if (status2 == false) {
                        status2 = true;
                      } else {
                        status2 = false;
                      }
                      // setState(() {
                      //   status2 = val;
                      // });
                    },
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              if (FirebaseAuth.instance.currentUser != null) {
                // Show the confirmation dialog.
                bool confirm = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Logout'),
                      content: Text('Apakah anda yakin ingin logout?'),
                      actions: [
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                        TextButton(
                          child: Text('Logout'),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                        ),
                      ],
                    );
                  },
                );

                // If the user confirmed, sign out of Google and Firebase authentication.
                if (confirm) {
                  await GoogleSignIn().signOut();
                  await FirebaseAuth.instance.signOut();

                  // Navigate back to the login page.
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }
              }
            },
            child: Text(
              'Logout',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    ),
  );
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            backgroundColor: Color(0xFFE0E0E0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: press,
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                height: 22,
                width: 22,
              ),
              // Icon(Icons.person, color: Colors.black, size: 22),
              SizedBox(width: 20),
              Expanded(
                  child: Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ],
          )),
    );
  }
}



// Column(
//           children: [
//             const SizedBox(height: 20),
//             Center(
//               child: SizedBox(
//                 height: 115,
//                 width: 155,
//                 child: Stack(
//                   fit: StackFit.expand,
//                   children: [
//                     CircleAvatar(
//                       backgroundImage: NetworkImage(
//                         "${user?.photoURL}",
//                         scale: 0.5,
//                       ),
//                     ),
//                     Positioned(
//                       right: 20,
//                       bottom: 0,
//                       child: SizedBox(
//                         height: 40,
//                         width: 40,
//                         child: TextButton(
//                           style: TextButton.styleFrom(
//                             padding: EdgeInsets.zero,
//                             backgroundColor: Color(0xFFE0E0E0),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                           ),
//                           onPressed: () {},
//                           child: SvgPicture.asset(
//                               "assets/icons/profile-camera.svg",
//                               color: Colors.black,
//                               height: 22,
//                               width: 22),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ProfileMenu(
//               text: '${user?.displayName}',
//               icon: "assets/icons/person.svg",
//               press: () {},
//             ),
//             ProfileMenu(
//               text: "${user?.email}",
//               icon: "assets/icons/email.svg",
//               press: () {},
//             ),
//             Container(
//               width: 360,
//               margin: EdgeInsets.symmetric(vertical: 15),
//               decoration: BoxDecoration(
//                 color: Color(0xFFE0E0E0),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: ListTile(
//                 title: Text(
//                   'Ganti Tema ',
//                   style: TextStyle(
//                       fontWeight: FontWeight.w600, color: Colors.black),
//                 ),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     FlutterSwitch(
//                       borderRadius: 30,
//                       width: 50,
//                       height: 30,
//                       activeColor: Colors.green,
//                       inactiveColor: Color.fromARGB(255, 94, 89, 89),
//                       value: status2,
//                       onToggle: (val) {
//                         themeProvider.toggleTheme();

//                         setState(() {
//                           status2 = val;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             TextButton(
//               onPressed: () async {
//                 if (FirebaseAuth.instance.currentUser != null) {
//                   // Show the confirmation dialog.
//                   bool confirm = await showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: Text('Logout'),
//                         content: Text('Apakah anda yakin ingin logout?'),
//                         actions: [
//                           TextButton(
//                             child: Text('Cancel'),
//                             onPressed: () {
//                               Navigator.of(context).pop(false);
//                             },
//                           ),
//                           TextButton(
//                             child: Text('Logout'),
//                             onPressed: () {
//                               Navigator.of(context).pop(true);
//                             },
//                           ),
//                         ],
//                       );
//                     },
//                   );

//                   // If the user confirmed, sign out of Google and Firebase authentication.
//                   if (confirm) {
//                     await GoogleSignIn().signOut();
//                     await FirebaseAuth.instance.signOut();

//                     // Navigate back to the login page.
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginScreen()),
//                     );
//                   }
//                 }
//               },
//               child: Text(
//                 'Logout',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             )
//           ],
//         )