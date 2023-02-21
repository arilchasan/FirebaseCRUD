import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:iconly/iconly.dart';

import 'my_firebase.dart';

class EditPage extends StatefulWidget {
  const EditPage({
    Key? key,
    required this.id,
    required this.nama,
    required this.nomor,
    required this.email,
  }) : super(key: key);
  final String id;
  final String nama;
  final String nomor;
  final String email;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController namaController;
  late final TextEditingController nomorController;
  late final TextEditingController emailController;

  @override
  void initState() {
    namaController = TextEditingController(text: widget.nama);
    nomorController = TextEditingController(text: widget.nomor);
    emailController = TextEditingController(text: widget.email);

    super.initState();
  }

  void editContact() async {
    if (_formKey.currentState!.validate()) {
      try {
        await MyFirebase.contactsCollection.doc(widget.id).update({
          'nama': namaController.text.trim(),
          'nomor': nomorController.text.trim(),
          'email': emailController.text.trim(),
        });
        Navigator.pop(context);
      } on FirebaseException {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Kontak gagal diubah'),
            backgroundColor: Colors.red[300],
          ),
        );
      }
    } else {
      // show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Masukkan semua data'),
          backgroundColor: Colors.red[300],
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    namaController.dispose();
    nomorController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Kontak",
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          // display avatar
          Center(
            child: Hero(
              tag: widget.id,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  "https://api.multiavatar.com/${widget.nama}.png",
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

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
                      onPressed: editContact,
                      icon: const Icon(Icons.edit),
                      label: const Text("Edit Kontak")),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
