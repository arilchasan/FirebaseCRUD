import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/main.dart';
import 'package:firebase_crud/my_firebase.dart';
import 'package:firebase_crud/push/push.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:iconly/iconly.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  final namaController = TextEditingController();
  final nomorController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    namaController.dispose();
    nomorController.dispose();
    emailController.dispose();
  }

  void addContact() async {
    if (_formKey.currentState!.validate()) {
      try {
        await MyFirebase.contactsCollection.add({
          'nama': namaController.text.trim(),
          'nomor': nomorController.text.trim(),
          'email': emailController.text.trim(),
        });
        Navigator.pop(context);
      } on FirebaseException {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Gagal menambahkan kontak'),
            backgroundColor: Colors.red[300],
          ),
        );
      }
    } else {
      // show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Masukkan data dengan benar'),
          backgroundColor: Colors.red[300],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Noti.initialize(flutterLocalNotificationsPlugin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Kontak "),
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: namaController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Masukkan nama";
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    hintText: "Nama",
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nomorController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Masukkan nomer telepon";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Nomer Telepon",
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Masukkan alamat email";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () {
                        addContact();
                        Noti.showBigTextNotification(
                            title: "Berhasil !!!",
                            body: "Kontak baru berhasil ditambahkan",
                            fln: flutterLocalNotificationsPlugin);
                      },
                      icon: const Icon(Icons.person),
                      label: const Text("Simpan")),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
