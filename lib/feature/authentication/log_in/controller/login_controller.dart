import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sportyo/core/const/app_colors.dart';
import '../../../../core/service_class/network_caller/repository/network_caller.dart';
import '../../../../core/service_class/network_caller/utility/usrls.dart';
import '../../../terms_and_condition/screen/terms_and_condition.dart';
import '../../auth_service/auth_service.dart';

class LogInController extends GetxController {
  // Form key to manage form validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers for TextFields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Observable boolean for login state
  var isLoginSelected = true.obs;

  // Function to toggle between login and create account
  void toggleLogin(bool value) {
    isLoginSelected.value = value;
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
          // Check if token and userId are correctly retrieved
          String? token = response.responseData['token'];
          String? userId = response.responseData['id'];
          if (token != null && userId != null) {
            await AuthService.saveToken(token, userId);
            emailController.clear();
            passwordController.clear();
            Get.offAll(() => const TermsAndCondition());
          } else {
            Get.snackbar(
              'Login Failed',
              'Invalid token or user ID in response.',
              snackPosition: SnackPosition.TOP,
              backgroundColor: AppColors.primaryColor,
              colorText: Colors.white,
            );
          }
        } else {
          Get.snackbar(
            'Login Failed',
            response.errorMessage ?? 'Unknown error occurred.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.primaryColor,
            colorText: Colors.white,
          );
        }
      } catch (e) {
        print('Error during login: $e');
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
