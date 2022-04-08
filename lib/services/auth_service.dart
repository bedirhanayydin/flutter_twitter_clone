import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/constants/strings.dart';
import 'package:flutter_twitter_clone/ui/feed/home_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //SignIn
  Future<User?> signIn(
      String email, String password, BuildContext context) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
      return user.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _warningToast(e.message.toString());
      } else if (e.code == 'wrong-password') {
        _warningToast(e.message.toString());
      } else if (e.code == 'invalid-email') {
        _warningToast(e.message.toString());
      }
    } catch (e) {
      _warningToast(TwitterCloneText.errorText);
    }
    return null;
  }

  //Logout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //SignUp
  Future<User?> createPerson(
    String name,
    String email,
    String password,
  ) async {
    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      //Cloud Firestore Collection Added
      await _firestore
          .collection("Person")
          .doc(user.user!.uid)
          .set({'userName': name, 'email': email});

      return user.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        _warningToast(e.message.toString());
      } else if (e.code == 'weak-password') {
        _warningToast(e.message.toString());
      }
    } catch (e) {
      _warningToast(TwitterCloneText.errorText);
    }
    return null;
  }

  Future<bool?> _warningToast(String text) {
    return Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xFF666666),
        fontSize: 15);
  }

  //Password Reset
  Future passwordReset(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
