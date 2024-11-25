import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ///Todo: save user in firebase

  Future<void> login() async {
    ///Todo: error handling
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
  }

  Future<void> register() async {
    ///Todo: error handling
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void clear() {
    emailController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    var inputDecoration = InputDecoration(
      hintText: "email",
      filled: true,
      fillColor: Theme.of(context).colorScheme.surfaceContainer,
    );
    var buttonStyle = Theme.of(context).textTheme.bodyLarge;
    var secondaryContainer = Theme.of(context).colorScheme.secondaryContainer;
    var roundedRectangleBorder =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: height / 8,
                ),
                Text(
                  "Sign in\nYour Account",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(
                  height: height / 8,
                ),
                TextFormField(
                  controller: emailController,
                  validator: (String? name) {
                    if (name?.isEmpty ?? true) {
                      return "please enter email";
                    }
                    return null;
                  },
                  decoration: inputDecoration,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  validator: (String? password) {
                    if (password?.isEmpty ?? true) {
                      return "please enter password";
                    }
                    return null;
                  },
                  decoration: inputDecoration.copyWith(
                    hintText: "Password",
                  ),
                ),
                SizedBox(
                  height: height / 12,
                ),
                MaterialButton(
                  color: secondaryContainer,
                  shape: roundedRectangleBorder,
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      login();
                    }
                  },
                  child: Text(
                    "Login",
                    style: buttonStyle,
                  ),
                ),
                MaterialButton(
                  color: secondaryContainer,
                  shape: roundedRectangleBorder,
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      register();
                    }
                  },
                  child: Text(
                    "register",
                    style: buttonStyle,
                  ),
                ),
                MaterialButton(
                  color: secondaryContainer,
                  shape: roundedRectangleBorder,
                  onPressed: () async {
                    signInWithGoogle();
                  },
                  child: Text(
                    "google",
                    style: buttonStyle,
                  ),
                ),
                MaterialButton(
                  color: secondaryContainer,
                  shape: roundedRectangleBorder,
                  onPressed: () async {
                    clear();
                  },
                  child: Text(
                    "clear",
                    style: buttonStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
