import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportyo/core/const/app_colors.dart';
import 'package:sportyo/core/const/app_texts.dart';
import 'package:sportyo/core/const/icons_path.dart';
import 'package:sportyo/core/global_widegts/authentication/custom_bottom.dart';

import '../../../../core/global_widegts/authentication/custom_sign_in_bottom.dart';
import '../../../../core/global_widegts/authentication/custom_text_field.dart';
import '../../../terms_and_condition/screen/terms_and_condition.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool isLoginSelected = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  isLoginSelected
                      ? Column(
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
                            CustomTextField(
                              labelText: AppTexts.email,
                              isPasswordField: false,
                              controller: _emailController,
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              labelText: AppTexts.password,
                              isPasswordField: true,
                              controller: _passwordController,
                            ),
                            SizedBox(height: 30.h),
                            CustomButton(
                                buttonText: AppTexts.signIn,
                                onPressed: () {
                                  Get.to(const TermsAndCondition());
                                  // if (_formKey.currentState!.validate()) {
                                  //   // Perform login action
                                  //   print('Email: ${_emailController.text}');
                                  //   print(
                                  //       'Password: ${_passwordController.text}');
                                  // }
                                }),
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
                            Center(
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
                            SizedBox(height: 70.h),
                          ],
                        )
                      : Column(
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
                              controller: _emailController,
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              labelText: AppTexts.password,
                              isPasswordField: true,
                              controller: _passwordController,
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              labelText: AppTexts.password,
                              isPasswordField: true,
                              controller: _passwordController,
                            ),
                            SizedBox(height: 30.h),
                            CustomButton(
                                buttonText: AppTexts.getStarted,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Perform login action
                                    print('Email: ${_emailController.text}');
                                    print(
                                        'Password: ${_passwordController.text}');
                                  }
                                }),
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
                            SizedBox(height: 70.h),
                          ],
                        ),
                  Container(
                    height: 50.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border:
                          Border.all(color: const Color(0xffe6f0fa), width: 2),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isLoginSelected = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isLoginSelected
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
                                      color: isLoginSelected
                                          ? const Color(0xff95a0ab)
                                          : Colors.black,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        // Log In Button
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isLoginSelected = true;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: isLoginSelected
                                    ? Colors.transparent
                                    : const Color(0xfff0f3f7),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12.r),
                                  bottomRight: Radius.circular(12.r),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(AppTexts.logIn,
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold,
                                      color: isLoginSelected
                                          ? Colors.black
                                          : const Color(0xff95a0ab),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
