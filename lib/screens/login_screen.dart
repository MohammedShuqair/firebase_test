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
  String? name;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      print("user ${userCredential.user.toString()}");
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${e.message}")));
      // TODO
    }
  }

  Future<void> register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);
      print("user ${userCredential.user.toString()}");
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${e.message}")));
      // TODO
    }
  }

  Future<UserCredential> signInWithGoogle() async {
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
    return await FirebaseAuth.instance.signInWithCredential(credential);
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
    print("rebuild");
    var inputDecoration = InputDecoration(
      hintText: "email",
      filled: true,
      fillColor: Colors.grey[200],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login", style: TextStyle(fontSize: 24)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: height / 4,
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
                SizedBox(
                  height: height / 12,
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
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      await login();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (_) => const HomeScreen()));
                    }
                  },
                  child: const Text("Login"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      await register();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (_) => const HomeScreen()));
                    }
                  },
                  child: const Text("register"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      UserCredential user = await signInWithGoogle();
                      print("user ${user.toString()}");
                    } catch (e, s) {
                      print("error ${e}");
                      print("stack ${s}");
                    }
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (_) => const HomeScreen()));
                  },
                  child: const Text("google"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    clear();
                  },
                  child: const Text("clear"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
