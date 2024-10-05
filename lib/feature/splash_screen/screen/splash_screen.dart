import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Image.asset(
      //         'assets/images/running.png',
      //         height: 150,
      //         width: 150,
      //       ),
      //       const SizedBox(height: 20),
      //       const Text(
      //         'Sportyo',
      //         style: TextStyle(
      //           fontSize: 28,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.green,
      //         ),
      //       ),
      //       const SizedBox(height: 10),
      //       const CircularProgressIndicator(),
      //     ],
      //   ),
      // ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
