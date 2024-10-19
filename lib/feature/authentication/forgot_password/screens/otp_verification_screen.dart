import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sportyo/core/const/app_colors.dart';
import '../../../profile/widget/global_text_style.dart';
import '../controller/otp_verification_controller.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({super.key, required this.email});
final String email;
  final otpController = Get.find<OtpVerificationController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.sp),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 100.h),
                Text(
                  'OTP Verification',
                  style: globalTextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Please enter the verification code that has been sent to your email.',
                  style: globalTextStyle(),
                ),
                SizedBox(height: 15.h),
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  onChanged: (value) {},
                  controller: otpController.otpController,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5.r),
                    fieldHeight: 50.h,
                    fieldWidth: 40.w,
                    activeFillColor: AppColors.primaryColor.withOpacity(0.1),
                    selectedFillColor: AppColors.primaryColor.withOpacity(0.5),
                    inactiveFillColor: Colors.white,
                    activeColor: AppColors.primaryColor,
                    selectedColor: AppColors.primaryColor,
                    inactiveColor: Colors.grey,
                  ),
                  cursorColor: AppColors.primaryColor,
                  keyboardType: TextInputType.number,
                  enableActiveFill: true,
                ),
                SizedBox(height: 15.h),
                Text(
                  'Set New Password',
                  style: globalTextStyle(),
                ),
                SizedBox(height: 15.h),
                SizedBox(
                  height: 40.h,
                  width: 273.w,
                  child: TextField(
                    controller: otpController.newPasswordTEController,
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      height: 24.h / 16.h,
                      color: AppColors.blackColor,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 5.h, horizontal: 10.w),
                      hintText: 'Enter your new password',
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        height: 24.h / 16.h,
                        color: AppColors.blackColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(
                            color: Color(0xff010101), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(
                            color: Color(0xff010101), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(
                            color: Color(0xff010101), width: 1),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Obx(() => Center(
                  child: Text(
                    otpController.start.value == 0
                        ? 'Didn’t receive the OTP?'
                        : 'Resend OTP in ${otpController.start.value} seconds',
                    style: globalTextStyle(
                        color: Colors.black,
                        fontSize: 14.sp),
                  ),
                )),
                SizedBox(height: 10.h),
                Obx(() => Center(
                  child: GestureDetector(
                    onTap: otpController.isResendEnabled.value
                        ? otpController.resendOtp
                        : null,
                    child: Text(
                      'Resend OTP',
                      style: globalTextStyle(
                        color: otpController.isResendEnabled.value
                            ? AppColors.primaryColor
                            : Colors.grey,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                )),
                SizedBox(height: 30.h),
                GestureDetector(
                  onTap: () {
                    otpController.otpSend(email);
                  },
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
                      'Save',
                      style: globalTextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
