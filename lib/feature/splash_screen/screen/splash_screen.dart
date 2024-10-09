import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .25,
          ),
          Image.asset("assets/images/icon/logo2.png"),
          const Spacer(),
          Image.asset(
            "assets/images/icon/branding2.png",
            width: MediaQuery.of(context).size.width * .5,
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
