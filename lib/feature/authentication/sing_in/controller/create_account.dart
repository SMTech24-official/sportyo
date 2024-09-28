import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sportyo/core/const/app_colors.dart';
import 'package:sportyo/feature/terms_and_condition/controller/terms_and_condition.dart';
import 'package:sportyo/feature/terms_and_condition/screen/terms_and_condition.dart';

import '../../../../core/service_class/network_caller/repository/network_caller.dart';
import '../../../../core/service_class/network_caller/utility/usrls.dart';

class CreateAccountController extends GetxController {
  final TermsAndConditionController termsAndConditionController =
      Get.find<TermsAndConditionController>();
  final GlobalKey<FormState> createAccountKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
    await Get.to(() => TermsAndCondition());
    if (termsAndConditionController.isAccept.value) {
      EasyLoading.show(status: 'Creating account...');

      try {
        // Call the API
        final response = await NetworkCaller()
            .postRequest(Urls.createAccount, body: requestBody);

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
    if (!termsAndConditionController.isAccept.value) {
      Get.snackbar(
        'Terms and Conditions',
        'You need to accept the Terms and Conditions to proceed.',
        icon: const Icon(Icons.error_outline, color: Colors.redAccent),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        borderRadius: 10,
        margin: const EdgeInsets.all(16),
        colorText: AppColors.whiteColor,
        duration: const Duration(seconds: 4),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
        reverseAnimationCurve: Curves.easeInBack,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
