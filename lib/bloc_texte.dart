// importer material
// ignore_for_file: prefer_const_constructors, unnecessary_new, unused_import, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:localstore/localstore.dart';

String retournerIdString(int salage) {
  return randomString(salage);
}

class BlocTexte extends StatefulWidget {
  @override
  _BlocTexte createState() => _BlocTexte();
}

class _BlocTexte extends State<BlocTexte> {
  late TextEditingController data_textInput;
  final db = Localstore.instance;
  String identifiant = 'todos';
  @override
  void initState() {
    super.initState();
    data_textInput = TextEditingController();
  }

  @override
  void dispose() {
    data_textInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          input_text(),
          buttonAjouter(),
          buttonGetAll(),
        ],
      ),
    );
  }

  Widget input_text() {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.3,
        child: TextField(
          controller: data_textInput,
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  Widget buttonAjouter() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          save_data();
        },
        child: Text('Ajouter'),
      ),
    );
  }

  Widget buttonGetAll() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          get_all_todos();
        },
        child: Text("Get all"),
      ),
    );
  }

  void save_data() async {
    String id = retournerIdString(5);
    db.collection(identifiant).doc(id).set({'texte': data_textInput.text});
    var recuperer = await db.collection(identifiant).doc(id).get();
    print(recuperer);
  }

  void get_all_todos() async {
    final data_all = await db.collection(identifiant).get();
    print(data_all);
  }
}
