import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/services/auth_service.dart';
import 'package:flutter_twitter_clone/strings/strings.dart';
import 'package:flutter_twitter_clone/ui/auth/intro_screen.dart';
import 'package:flutter_twitter_clone/ui/auth/sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var size, height, width;
  final emailController = TextEditingController();
  late final passwordController = TextEditingController();
  late final nameController = TextEditingController();
  late final rePasswordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

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
          nameTextField(),
          emailTextField(),
          passwordTextField(),
          rePasswordTextField(),
          const SizedBox(
            height: 70,
          ),
          signUpButton(),
          const SizedBox(
            height: 70,
          ),
          if (_isLoading) const CircularProgressIndicator(),
        ],
      ),
    );
  }

  Padding nameTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      child: TextField(
        controller: nameController,
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
          hintText: 'Name',
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Padding emailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
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
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
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

  Padding rePasswordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      child: TextField(
        controller: rePasswordController,
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
          hintText: 'Confirm password',
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  GestureDetector signUpButton() {
    return GestureDetector(
      onTap: () => _registerUser(),
      child: Container(
        alignment: Alignment.center,
        width: 335,
        height: 45,
        decoration: BoxDecoration(
          color: const Color(0xFF1da2ef),
          borderRadius: BorderRadius.circular(40),
        ),
        child: const Text(
          'Sign up',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
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
        'Sign Up',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Future<void> _registerUser() async {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        rePasswordController.text.isNotEmpty &&
        passwordController.text == rePasswordController.text) {
      setState(() {
        _isLoading = true;
      });
      if (!validateEmail(emailController.text.trim())) {
        await _warningToast(TwitterCloneText.loginWrongEmailText);
      } else {
        _authService
            .createPerson(
          nameController.text.trim(),
          emailController.text.trim(),
          passwordController.text.trim(),
        )
            .then((value) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const SignIn()),
              (route) => false);
        }).catchError((error) {
          _warningToast(TwitterCloneText.errorText);
        }).whenComplete(() {
          setState(() {
            _isLoading = false;
          });
        });
      }
    } else {
      _warningToast(TwitterCloneText.emptyText);
    }
  }

  Future<bool?> _warningToast(String text) {
    return Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        fontSize: 25);
  }

  validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }
}
