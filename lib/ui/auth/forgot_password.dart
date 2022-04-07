import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/services/auth_service.dart';
import 'package:flutter_twitter_clone/constants/strings.dart';
import 'package:flutter_twitter_clone/ui/auth/intro_screen.dart';
import 'package:flutter_twitter_clone/ui/auth/sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }

class _ForgotPasswordState extends State<ForgotPassword> {
  late final emailController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(context),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Forgot Password',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23)),
          const SizedBox(
            height: 20,
          ),
          const Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30),
              child: Text(TwitterCloneText.forgotPasswordSubTitle,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      color: Colors.grey))),
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30),
              child: emailTextField()),
          submitButton(),
          const SizedBox(
            height: 20,
          ),
          if (_isLoading) const CircularProgressIndicator(),
        ]),
      ),
    );
  }

  GestureDetector submitButton() {
    return GestureDetector(
      onTap: () => _resetPassword(),
      child: Container(
        alignment: Alignment.center,
        width: 335,
        height: 45,
        decoration: BoxDecoration(
          color: const Color(0xFF1da2ef),
          borderRadius: BorderRadius.circular(40),
        ),
        child: const Text(
          'Submit',
          style: TextStyle(
            fontSize: 17,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  _resetPassword() {
    if (emailController.text.isEmpty) {
      _warningToast(TwitterCloneText.loginWrongEmailText);
    } else {
      setState(() {
        _isLoading = true;
      });
      _authService.passwordReset(emailController.text.trim()).then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SignIn()),
            (route) => false);
      }).catchError((error) {
        if (error.toString().contains('invalid-email')) {
          _warningToast(TwitterCloneText.loginWrongEmailText);
          _warningToast(error);
        } else if (error.toString().contains('ERROR_USER_NOT_FOUND')) {
          _warningToast(TwitterCloneText.loginNoAccountText);
        } else if (error.toString().contains('wrong-password')) {
          _warningToast(TwitterCloneText.loginWrongPasswordText);
        } else {
          _warningToast(TwitterCloneText.errorText);
        }
      }).whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  Future<bool?> _warningToast(String text) {
    return Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color(0xFF666666),
        fontSize: 15);
  }

  TextField emailTextField() {
    return TextField(
      controller: emailController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent, width: 0.0),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 238, 238, 238),
        hintText: 'Enter email',
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        color: Colors.blue,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const IntroScreen()));
        },
        icon: const Icon(Icons.arrow_back),
      ),
      title: const Text(
        TwitterCloneText.forgotPasswordTitle,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
