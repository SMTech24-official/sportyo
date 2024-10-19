import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sportyo/feature/authentication/log_in/screen/log_in.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/service_class/network_caller/repository/network_caller.dart';
import '../../../../core/service_class/network_caller/utility/usrls.dart';

class OtpVerificationController extends GetxController {
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordTEController = TextEditingController();

  var isResendEnabled = false.obs;
  var start = 60.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    isResendEnabled.value = false;
    start.value = 300; // Set timer to 5 minutes (300 seconds)
    _timer?.cancel(); // Cancel any previous timer before starting a new one
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (start.value == 0) {
        isResendEnabled.value = true;
        timer.cancel();
      } else {
        start.value--;
      }
    });
  }

  void resendOtp() {
    startTimer(); // Restart the timer
  }

  Future<void> otpSend(String email) async {
    final Map<String, String> requestBody = {
      'email': email.trim(),
      'otp': otpController.text.trim(),
      'password': newPasswordTEController.text.trim(),
    };

    if (otpController.text.isEmpty || otpController.text.length != 6) {
      Get.snackbar(
        'Invalid OTP',
        'Please enter a valid 6-digit OTP',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.primaryColor,
        colorText: AppColors.whiteColor,
        borderRadius: 10,
        margin: EdgeInsets.all(16.sp),
        animationDuration: const Duration(milliseconds: 300),
        duration: const Duration(seconds: 3),
      );
      return;
    }

    if (newPasswordTEController.text.isEmpty || newPasswordTEController.text.length < 8) {
      Get.snackbar(
        'Invalid Password',
        'Your password must be at least 8 characters long.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.primaryColor,
        colorText: AppColors.whiteColor,
        borderRadius: 10,
        margin: EdgeInsets.all(16.sp),
        animationDuration: const Duration(milliseconds: 300),
        duration: const Duration(seconds: 3),
      );
      return;
    }

    try {
      EasyLoading.show(status: 'Loading...');
      final response = await NetworkCaller().postRequest(Urls.otpSend, body: requestBody);
      if (response.isSuccess) {
        Get.offAll(() => const LogIn());
      } else {
        Get.snackbar(
          'Login Failed',
          'Invalid token or user ID in response.',
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
  }

}
