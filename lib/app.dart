import 'package:flutter/material.dart';
import 'package:sportyo/feature/authentication/log_in/screen/log_in.dart';

class Sprotyo extends StatelessWidget {
  const Sprotyo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     home: LogIn(),
    );
  }
}