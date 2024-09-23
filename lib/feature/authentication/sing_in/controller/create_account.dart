import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccountController extends GetxController {
  // Controllers for form fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // Form validation key
  final formKey = GlobalKey<FormState>();

  // Method to handle account creation
  void createAccount() {
    if (formKey.currentState!.validate()) {
      Future.delayed(Duration(seconds: 2), () {

        Get.snackbar("Success", "Account Created Successfully!");
      });
    }
  }

  @override
  void onClose() {
    // Dispose the controllers when the controller is removed
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
