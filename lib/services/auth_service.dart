import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //SignIn
  Future<User?> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  //Logout
  signOut() async {
    return await _auth.signOut();
  }

  //SignUp
  Future<User?> createPerson(
    String name,
    String email,
    String password,
  ) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    //Cloud Firestore Collection Added
    await _firestore
        .collection("Person")
        .doc(user.user!.uid)
        .set({'userName': name, 'email': email});

    return user.user;
  }

  //Password Reset
  Future passwordReset(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<String?> getCurrentUser() async {
    final uid = _auth.currentUser;
    if (uid != null) {
      await uid.reload();
    }
    return uid?.email;
  }
}
