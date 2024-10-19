import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportyo/core/const/app_colors.dart';
import 'package:sportyo/core/const/app_texts.dart';
import 'package:sportyo/core/const/icons_path.dart';
import 'package:sportyo/core/const/image_path.dart';
import 'package:sportyo/core/global_widegts/authentication/custom_bottom.dart';
import 'package:sportyo/feature/authentication/log_in/widget/show_forgot_password_dialog.dart';

import '../../../../core/global_widegts/authentication/custom_sign_in_bottom.dart';
import '../../../../core/global_widegts/authentication/custom_text_field.dart';
import '../../sing_in/screen/create_account.dart';
import '../controller/login_controller.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller with GetX
    final LogInController loginController = Get.find<LogInController>();

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w),
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                children: [
                  loginController.isLoginSelected.value
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(
                                ImagePath.logoText,
                                width: MediaQuery.of(context).size.width * .5,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Text(
                              AppTexts.wellCome,
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
                              AppTexts.fillOut,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.blackColor,
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            CustomTextFieldForAuth(
                              labelText: AppTexts.email,
                              isPasswordField: false,
                              controller: loginController.emailController,
                            ),
                            SizedBox(height: 20.h),
                            CustomTextFieldForAuth(
                              labelText: AppTexts.password,
                              isPasswordField: true,
                              controller: loginController.passwordController,
                            ),
                            SizedBox(height: 30.h),
                            CustomButton(
                              buttonText: AppTexts.signIn,
                              onPressed: loginController.login,
                            ),
                            SizedBox(height: 20.h),
                            Center(
                              child: Text(
                                AppTexts.orSing,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColors.blackColor),
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
                            SizedBox(height: 20.h),
                            GestureDetector(
                              onTap: () {
                                showForgotPasswordDialog(context);
                              },
                              child: Center(
                                child: Text(
                                  AppTexts.forgot,
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xff95a0ab),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 70.h),
                          ],
                        )
                      : CreateAccount(),
                  // Toggle between login and create account
                  Container(
                    height: 50.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                          color: const Color(0xffe6f0fa), width: 2),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => loginController.toggleLogin(false),
                            child: Container(
                              decoration: BoxDecoration(
                                color: loginController.isLoginSelected.value
                                    ? const Color(0xfff0f3f7)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12.r),
                                  bottomLeft: Radius.circular(12.r),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(AppTexts.createAccount,
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: loginController
                                              .isLoginSelected.value
                                          ? const Color(0xff95a0ab)
                                          : Colors.black,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => loginController.toggleLogin(true),
                            child: Container(
                              decoration: BoxDecoration(
                                color: loginController.isLoginSelected.value
                                    ? Colors.transparent
                                    : const Color(0xfff0f3f7),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12.r),
                                  bottomRight: Radius.circular(12.r),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                AppTexts.logIn,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        loginController.isLoginSelected.value
                                            ? Colors.black
                                            : const Color(0xff95a0ab),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
