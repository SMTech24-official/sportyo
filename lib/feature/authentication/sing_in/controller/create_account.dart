import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sportyo/core/const/app_colors.dart';
import 'package:sportyo/feature/authentication/log_in/controller/login_controller.dart';
import 'package:sportyo/feature/terms_and_condition/controller/terms_and_condition.dart';
import 'package:sportyo/feature/terms_and_condition/screen/terms_and_condition.dart';

import '../../../../core/service_class/network_caller/repository/network_caller.dart';
import '../../../../core/service_class/network_caller/utility/usrls.dart';
import '../../../home/screen/home.dart';
import '../../../profile/controller/profile_controller.dart';
import '../../../profile/screen/profile_edit.dart';
import '../../auth_service/auth_service.dart';

class CreateAccountController extends GetxController {
  final LogInController loginController = Get.find<LogInController>();
  final TermsAndConditionController termsAndConditionController =
      Get.find<TermsAndConditionController>();
  final ProfileViewController controllerProfile =
      Get.put(ProfileViewController());
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
          String? token = response.responseData['token'];
          String? userId = response.responseData['id'];
          if (token != null && userId != null) {
            await AuthService.saveToken(token, userId);
            // EasyLoading.showSuccess("Account created successfully");
            // log(token);
            // log(userId);
            // Get.offAll(() => Home());
            // emailController.clear();
            // passwordController.clear();
            // confirmPasswordController.clear();
            controllerProfile.fetchUserData().then((value) async {
              if ((controllerProfile.userModel.value.firstName?.isEmpty ??
                      true) &&
                  (controllerProfile.userModel.value.sportsDetails.isEmpty)) {
                log('First name: ${controllerProfile.userModel.value.firstName}');
                log('Sports details: ${controllerProfile.userModel.value.sportsDetails}');
                Get.offAll(() => const ProfileViewScreen());
              } else {
                Get.offAll(() => Home());
              }
            });
          }
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
