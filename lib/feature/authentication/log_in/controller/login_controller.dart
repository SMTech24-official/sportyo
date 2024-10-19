import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sportyo/core/const/app_colors.dart';
import 'package:sportyo/feature/home/screen/home.dart';
import 'package:sportyo/feature/profile/screen/profile_edit.dart';
import '../../../../core/service_class/network_caller/repository/network_caller.dart';
import '../../../../core/service_class/network_caller/utility/usrls.dart';
import '../../../splash_screen/controller/splash_screen_controller.dart';
import '../../auth_service/auth_service.dart';

class LogInController extends GetxController {

  final SplashController controllerProfile = Get.put(SplashController());
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
    if (emailController.text.isNotEmpty&&passwordController.text.isNotEmpty) {
      final Map<String, String> requestBody = {
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      };

      try {
        EasyLoading.show(status: 'Loading...');
        final response =
            await NetworkCaller().postRequest(Urls.login, body: requestBody);
        if (response.isSuccess) {
          // Check if token and userId are correctly retrieved
          String? token = response.responseData['token'];
          String? userId = response.responseData['id'];
          if (token != null && userId != null) {
            await AuthService.saveToken(token, userId);
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
            'Login Unsuccessful',
            'Unable to log in. Please verify your email and password and try again.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: AppColors.primaryColor,
            colorText: Colors.white,
            icon: const Icon(Icons.error, color: Colors.white),
            margin: const EdgeInsets.all(16),
            borderRadius: 8,
            duration: const Duration(seconds: 2),
          );

        }
      } catch (e) {
        log('Login error: $e');
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
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
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
