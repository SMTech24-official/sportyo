import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../core/service_class/network_caller/repository/network_caller.dart';
import '../../../../core/service_class/network_caller/utility/usrls.dart';

class CreateAccountController extends GetxController {
  final GlobalKey<FormState> createAccountKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // This method handles the account creation logic
  Future<void> createAccount() async {
    // Validate form inputs
    if (!createAccountKey.currentState!.validate()) {
      EasyLoading.showError('Please fill in all fields correctly.');
      return;
    }

    // Check if password matches confirm password
    if (passwordController.text != confirmPasswordController.text) {
      EasyLoading.showError('Passwords do not match.');
      return;
    }

    // Prepare request body for API call
    final Map<String, String> requestBody = {
      'email': emailController.text.trim(),
      'password': passwordController.text.trim(),
    };

    // Show loading indicator
    EasyLoading.show(status: 'Creating account...');

    try {
      // Call the API
      final response = await NetworkCaller().postRequest(Urls.createAccount, body: requestBody);

      // If success, show success message and clear controllers
      if (response.isSuccess) {
        EasyLoading.showSuccess("Account created successfully");

        // Clear all form fields after successful account creation
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        // Get.to(NextScreen());
      } else {
        // Show error message in case of failure
        EasyLoading.showError('User with this email already exists');
      }
    } catch (e) {
      // Handle any exceptions
      EasyLoading.showError('Something went wrong. Please try again later.');
    } finally {
      // Dismiss loading indicator
      EasyLoading.dismiss();
    }
  }

  // Dispose controllers when not needed
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
