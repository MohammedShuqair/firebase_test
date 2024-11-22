import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test/screens/home_screen.dart';
import 'package:firebase_test/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Stream<User?> stream = FirebaseAuth.instance.authStateChanges();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: stream,
        builder: (context, snapshot) {
          print("snapshot ${snapshot.toString()}");
          if (snapshot.hasData) {
            return HomeScreen();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
