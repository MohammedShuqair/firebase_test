import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> ids = [];
  List<Map<String, dynamic>> docs = [];
  UserRepo userRepo = UserRepo();

  @override
  void initState() {
    super.initState();
  }

  void getUsers() {
    try {
      userRepo.getUsers().listen((qSnapShot) {
        ids.clear();
        docs.clear();
        for (final doc in qSnapShot.docs) {
          ids.add(doc.id);
          docs.add(doc.data());
          setState(() {});
        }
      });
    } catch (e, s) {
      print("error $e");
      print("error $s");
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
            icon: const Icon(Icons.logout),
          ),
          IconButton(
            onPressed: () {
              getUsers();
            },
            icon: const Icon(Icons.get_app),
          )
        ],
      ),
      body: ListView.separated(
        itemBuilder: (_, index) => ListTile(
          leading: Text(ids[index]),
          title: Text(docs[index].toString()),
        ),
        separatorBuilder: (_, index) => const SizedBox(
          height: 10,
        ),
        itemCount: docs.length,
      ),
    );
  }
}
