import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/ui/auth/sign_in.dart';
import 'package:flutter_twitter_clone/ui/auth/sign_up.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() {
    return _IntroScreenState();
  }
}

class _IntroScreenState extends State<IntroScreen> {
  final String iconPath = 'assets/images/twitter_bird.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "See what's happening in\nthe world right now.",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUp()));
            },
            child: Container(
              alignment: Alignment.center,
              width: 280,
              height: 45,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 59, 159, 241),
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Text(
                'Create an account',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 65.0, vertical: 50),
            child: Row(
              children: [
                Text('Have an account already? ',
                    style: GoogleFonts.roboto(
                      fontSize: 15,
                      color: Colors.grey[700],
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignIn()));
                  },
                  child: Text('Log in ',
                      style: GoogleFonts.roboto(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 76, 161, 240),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBarWidget() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            fit: BoxFit.contain,
            height: 30,
          ),
        ],
      ),
      centerTitle: true,
    );
  }
}
