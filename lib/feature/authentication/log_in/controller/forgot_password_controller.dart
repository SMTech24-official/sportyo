import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sportyo/core/service_class/network_caller/repository/network_caller.dart';
import 'package:sportyo/core/service_class/network_caller/utility/usrls.dart';
import 'package:sportyo/feature/authentication/forgot_password/screens/otp_verification_screen.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final RxString errorMessage = ''.obs;

  bool _isValidEmail(String email){
    return email.isNotEmpty && GetUtils.isEmail(email);
  }

  Future<void> forgotPassword()async{
    String email=emailController.text.trim();
    if(!_isValidEmail(email)){
      errorMessage.value = 'Please enter a valid email address';
      return;
    }
    errorMessage.value = '';
    EasyLoading.show(status: "Loading...");
    try {
      final Map<String, String> requestBody = {
        'email': email,
      };
      // Send reset email via network request
      final response = await NetworkCaller().postRequest(Urls.sendEmail,body: requestBody);

      // Handle response success
      if (response.isSuccess) {
        Get.offAll(OtpVerificationScreen(email: email,));

      } else {
        EasyLoading.showError('Failed to send reset email. Please try again.');
      }
    } catch (error) {
      EasyLoading.showError('An error occurred. Please try again later.');

    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
