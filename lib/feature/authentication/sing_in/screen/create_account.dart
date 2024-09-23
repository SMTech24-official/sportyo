import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/const/app_colors.dart';
import '../../../../core/const/app_texts.dart';
import '../../../../core/const/icons_path.dart';
import '../../../../core/global_widegts/authentication/custom_bottom.dart';
import '../../../../core/global_widegts/authentication/custom_sign_in_bottom.dart';
import '../../../../core/global_widegts/authentication/custom_text_field.dart';
import '../controller/create_account.dart';

class CreateAccount extends StatelessWidget {
  CreateAccount({super.key});

  // Bind the controller
  final CreateAccountController controller = Get.find<CreateAccountController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                AppTexts.appName,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  textStyle: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Text(
              AppTexts.createAccount,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              AppTexts.les,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.blackColor,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              labelText: AppTexts.email,
              isPasswordField: false,
              controller: controller.emailController,
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              labelText: AppTexts.password,
              isPasswordField: true,
              controller: controller.passwordController,
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              labelText: AppTexts.password,
              isPasswordField: true,
              controller: controller.confirmPasswordController,
            ),
            SizedBox(height: 30.h),
            CustomButton(
              buttonText: AppTexts.getStarted,
              onPressed: controller.createAccount,
            ),
            SizedBox(height: 20.h),
            Center(
              child: Text(
                AppTexts.orSing,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      fontSize: 14.sp, color: AppColors.blackColor),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            CustomSignInButton(
              text: AppTexts.continueWithGoogle,
              imagePath: IconsPath.googleIcon,
              onPressed: () {},
            ),
            SizedBox(height: 20.h),
            CustomSignInButton(
              text: AppTexts.continueWithApple,
              imagePath: IconsPath.appleIcon,
              onPressed: () {},
            ),
            SizedBox(height: 70.h),
          ],
        ),
      ),
    );
  }
}
