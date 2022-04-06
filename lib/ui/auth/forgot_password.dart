import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/ui/auth/intro_screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'Forgot Password',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30.0, right: 30),
            child: Text(
              'Enter your email address below to receive password reset instruction',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 30),
            child: emailTextField(),
          ),
          submitButton(),
        ]),
      ),
    );
  }

  GestureDetector submitButton() {
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

  TextField emailTextField() {
    return TextField(
      controller: emailController,
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
        'Forgot Password',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
