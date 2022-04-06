import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/ui/auth/intro_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var size, height, width;
  late final emailController = TextEditingController();
  late final passwordController = TextEditingController();
  late final nameController = TextEditingController();
  late final rePasswordController = TextEditingController();

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
      onTap: () {},
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
}
