import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Add this import
import 'package:sportyo/core/const/app_colors.dart';

import '../../../../core/service_class/network_caller/repository/network_caller.dart';
import '../../../../core/service_class/network_caller/utility/usrls.dart';
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

  // Function to toggle between login and create account
  void toggleLogin(bool value) {
    isLoginSelected.value = value;
  }
  Future<void> saveTokenAndID(String token, String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('user_id', id);
    // Print token and ID to the console
    print("Token: $token");
    print("User ID: $id");
  }
  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Loading...');
      final Map<String, String> requestBody = {
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      };

      try {
        final response =
        await NetworkCaller().postRequest(Urls.login, body: requestBody);
        if (response.isSuccess) {
          final token = response.responseData['data']['token'];
          final userId = response.responseData['data']['id'];
          await saveTokenAndID(token, userId);
          Get.to(() => const TermsAndCondition());
        } else {
          Get.snackbar(
            'Login Failed',
            response.errorMessage,
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.primaryColor,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'Something went wrong. Please try again later.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
        );
      } finally {
        EasyLoading.dismiss();
      }
    } else {
      Get.snackbar(
        'Invalid Input',
        'Please fill in all fields correctly.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
