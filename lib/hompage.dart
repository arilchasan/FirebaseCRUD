import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/add.dart';
import 'package:firebase_crud/editpage.dart';
import 'package:firebase_crud/login/login.dart';
import 'package:firebase_crud/my_firebase.dart';
import 'package:firebase_crud/profile.dart';
import 'package:firebase_crud/push/push.dart';
import 'package:firebase_crud/settings.dart';
import 'package:firebase_crud/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final kontak = MyFirebase.contactsCollection.snapshots();
  int _counter = 0;

  void _incrementCounter() async {
    String? fcmKey = await getFcmToken();
    print('fcmKey: $fcmKey');
  }
  // int _counter = 0;

  // void _incrementCounter() async {
  //   String? fcmKey = await getFcmToken();
  //   print('fcmKey: $fcmKey');
  // }

  void deleteContact(String id) async {
    await MyFirebase.contactsCollection.doc(id).delete();
    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      SnackBar(
        content: const Text('Kontak berhasil dihapus'),
        backgroundColor: Colors.red[300],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Kontak"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => profile()),
                  );
                  _incrementCounter();
                },
                icon: Icon(IconlyBroken.profile))
            //
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: kontak,
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                final List<QueryDocumentSnapshot> documents =
                    snapshot.data!.docs;
                if (documents.isEmpty) {
                  return Center(
                    child: Text(
                      "Tidak ada Kontak!",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: documents.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final contactId = documents[index].id;
                    final contact =
                        documents[index].data() as Map<String, dynamic>;
                    final String nama = contact['nama'];
                    final String nomor = contact['nomor'];
                    final String email = contact['email'];
                    final String avatar =
                        "https://api.multiavatar.com/$nama.png";
                    showAlertDialog(BuildContext context) {
                      // set up the buttons
                      Widget cancelButton = TextButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      );
                      Widget continueButton = TextButton(
                        child: Text("Delete"),
                        onPressed: () {
                          deleteContact(contactId);
                          Navigator.pop(context);
                        },
                      );

                      // set up the AlertDialog
                      AlertDialog alert = AlertDialog(
                        title: Text("Hapus Kontak"),
                        content: Text("Apakah anda yakin ingin menghapus?"),
                        actions: [
                          cancelButton,
                          continueButton,
                        ],
                      );

                      // show the dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    }

                    return ListTile(
                      onTap: () {},
                      leading: Hero(
                        tag: contactId,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            avatar,
                          ),
                        ),
                      ),
                      title: Text(nama),
                      subtitle: Text("$nomor \n$email"),
                      isThreeLine: true,
                      //  trailing should be delete and edit button
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditPage(
                                    id: contactId,
                                    nama: nama,
                                    nomor: nomor,
                                    email: email,
                                  ),
                                ),
                              );
                            },
                            splashRadius: 24,
                            icon: const Icon(
                              IconlyBroken.edit,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showAlertDialog(context);
                              // deleteContact(contactId);
                            },
                            splashRadius: 24,
                            icon: const Icon(
                              IconlyBroken.delete,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text("An Error Occured"),
                );
              }
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }),
        floatingActionButton: FloatingActionButton(
          child: const Icon(IconlyBroken.add_user),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddPage(),
              ),
            );
          },
        ));
  }
}

Future<String?> getFcmToken() async {
  if (Platform.isIOS) {
    String? fcmKey = await FirebaseMessaging.instance.getToken();
    return fcmKey;
  }
  String? fcmKey = await FirebaseMessaging.instance.getToken();
  return fcmKey;
}
