import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int counter = 0;
  List<String> ids = [];
  List<Map<String, dynamic>> docs = [];

  @override
  void initState() {
    super.initState();
  }

  void getUsers() {
    try {} catch (e, s) {
      print("error ${e}");
      print("error ${s}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              getUsers();
            },
            icon: Icon(Icons.get_app),
          )
        ],
      ),
      body: ListView.separated(
        itemBuilder: (_, index) => ListTile(
          leading: Text(ids[index]),
          title: Text(docs[index].toString()),
        ),
        separatorBuilder: (_, index) => SizedBox(
          height: 10,
        ),
        itemCount: docs.length,
      ),
    );
  }
}
