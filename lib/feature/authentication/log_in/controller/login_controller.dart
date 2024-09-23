import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../terms_and_condition/screen/terms_and_condition.dart';

class LogInController extends GetxController {
  // Form key to manage form validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers for TextFields
  late TextEditingController emailController;
  late TextEditingController passwordController;

  // Observable boolean for login state
  var isLoginSelected = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize TextControllers
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    // Dispose of the controllers when done
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Function to toggle between login and create account
  void toggleLogin(bool value) {
    isLoginSelected.value = value;
  }

  // Function to validate form and perform login action
  void login() {
    Get.to(() => const TermsAndCondition());
    // if (formKey.currentState!.validate()) {
    //
    //   print("Email: ${emailController.text}, Password: ${passwordController.text}");
    // } else {
    //   // Get.snackbar(AppTexts.error, AppTexts.invalidInput,
    //   //     snackPosition: SnackPosition.BOTTOM);
    // }
  }
}
