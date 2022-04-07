import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/services/auth_service.dart';
import 'package:flutter_twitter_clone/constants/strings.dart';
import 'package:flutter_twitter_clone/ui/auth/forgot_password.dart';
import 'package:flutter_twitter_clone/ui/auth/intro_screen.dart';
import 'package:flutter_twitter_clone/ui/feed/home_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var size, height, width;
  late final emailController = TextEditingController();
  late final passwordController = TextEditingController();
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBarWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          emailTextField(),
          passwordTextField(),
          const SizedBox(
            height: 70,
          ),
          loginButton(),
          const SizedBox(
            height: 70,
          ),
          forgotPassword(context),
          const SizedBox(
            height: 70,
          ),
          googleButton(),
        ],
      ),
    );
  }

  GestureDetector forgotPassword(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ForgotPassword())),
      child: const Text(
        'Forgot password?',
        style: TextStyle(
            color: Color.fromARGB(255, 42, 152, 241),
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding emailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      child: TextField(
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
          fillColor: Colors.grey[200],
          hintText: 'Enter email',
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Padding passwordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextField(
        controller: passwordController,
        obscureText: true,
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
          hintText: 'Enter password',
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  GestureDetector loginButton() {
    return GestureDetector(
      onTap: () => _loginWithEmail(),
      child: Container(
        alignment: Alignment.center,
        width: 335,
        height: 45,
        decoration: BoxDecoration(
          color: const Color(0xFF1da2ef),
          borderRadius: BorderRadius.circular(40),
        ),
        child: const Text(
          'Login',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _loginWithEmail() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      _authService
          .signIn(
        emailController.text.trim(),
        passwordController.text.trim(),
      )
          .then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (route) => false);
      }).catchError((error) {
        if (error.toString().contains('invalid-email')) {
          _warningToast(TwitterCloneText.loginWrongEmailText);
        } else if (error.toString().contains('user-not-found')) {
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
    } else {
      _warningToast(TwitterCloneText.emptyText);
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

  GestureDetector googleButton() {
    return GestureDetector(
      onTap: () {
        Fluttertoast.showToast(msg: 'Not Active :(');
      },
      child: Container(
        alignment: Alignment.center,
        width: 335,
        height: 45,
        decoration: BoxDecoration(boxShadow: const <BoxShadow>[
          BoxShadow(
              color: Color.fromARGB(137, 139, 139, 139),
              blurRadius: 15.0,
              offset: Offset(0.0, 0.75))
        ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            FaIcon(
              FontAwesomeIcons.google,
              color: Colors.red,
            ),
            Text(
              'Continue with Google',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 133, 133, 133),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBarWidget() {
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
        'Sign In',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
