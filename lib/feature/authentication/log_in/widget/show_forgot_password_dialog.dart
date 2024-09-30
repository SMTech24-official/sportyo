import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/const/app_colors.dart';
import '../../../profile/widget/global_text_style.dart';
import '../controller/forgot_password_controller.dart';

void showForgotPasswordDialog(BuildContext context) {
  final ForgotPasswordController controller =
      Get.put(ForgotPasswordController());
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        content: SizedBox(
          width: 320.w,
          height: 240.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Forgot Password',
                  style: globalTextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    lineHeight: 30.sp / 22.sp,
                    color: AppColors.purplecolor,
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'Enter your email to reset your password',
                style: globalTextStyle(
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 15.h),
              SizedBox(
                height: 35.h,
                width: 273.w,
                child: TextField(
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (_) {
                    controller.errorMessage.value = '';
                  },
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    height: 24.h / 16.h,
                    color: AppColors.blackColor,
                  ),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    hintText: 'Email address',
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      height: 24.h / 16.h,
                      color: AppColors.blackColor,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide:
                          const BorderSide(color: Color(0xff010101), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide:
                          const BorderSide(color: Color(0xff010101), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide:
                          const BorderSide(color: Color(0xff010101), width: 1),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Obx(
                () => controller.errorMessage.isNotEmpty
                    ? Text(
                        controller.errorMessage.value,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.red,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: controller.forgotPassword,
                child: Container(
                    height: 50.h,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.purplecolor,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      'Send',
                      style: globalTextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.whiteColor,
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
