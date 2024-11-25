import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepo {
  static const usersCollection = "users";

  Future<UserCredential> login(
      {required String email, required String pass}) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass);
  }

  Future<UserCredential> register(
      {required String email, required String pass}) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass);
    await addUser(userCredential.user);
    return userCredential;
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

  /// add authenticated user to firestore
  Future<void> addUser(User? user) async {
    if (user != null) {
      await FirebaseFirestore.instance
          .collection(usersCollection)
          .doc(user.uid)
          .set(
              {
            "email": user.email,
            "name": user.displayName,
            "photoUrl": user.photoURL,
            "uid": user.uid,
          },
              SetOptions(
                merge: true,
              ));
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() {
    return FirebaseFirestore.instance.collection(usersCollection).snapshots();
  }
}
