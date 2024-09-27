import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/const/app_colors.dart';
import '../../../profile/widget/global_text_style.dart';

void showForgotPasswordDialog(BuildContext context) {
  final TextEditingController emailController = TextEditingController();
  final RxString errorMessage = ''.obs; // For reactive error handling

  showDialog(
    context: context,
    barrierDismissible: true, // Allow dismiss by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        contentPadding: EdgeInsets.all(20.w), // Add padding for better spacing
        content: SizedBox(
          width: 320.w, // Adjusted width for better readability
          height: 240.h, // Adjusted height for better space utilization
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
                  // color: AppColors.,
                ),
              ),
              SizedBox(height: 15.h),

              SizedBox(
                height: 35.h,
                width: 273.w,
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (_) {
                    errorMessage.value = ''; // Clear error on input change
                  },
                  style: GoogleFonts.sourceSans3(
                      fontSize:16.sp,
                      fontWeight: FontWeight.w400,
                      height: 24.h / 16.h,
                      color: AppColors.blackColor),
                  decoration: InputDecoration(
                    contentPadding:  EdgeInsets.symmetric(
                        vertical: 5.h, horizontal: 10.w),
                    hintText: 'Email address',
                    hintStyle: GoogleFonts.sourceSans3(
                        fontSize:16.sp,
                        fontWeight: FontWeight.w400,
                        height:24.h / 16.h,
                        color: AppColors.blackColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(color: Color(0xff010101), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(color: Color(0xff010101), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: const BorderSide(color: Color(0xff010101), width: 1),
                    ),

                  ),
                ),
              ),
              SizedBox(height: 8.h),
              // Reactive error message
              Obx(
                    () => errorMessage.isNotEmpty
                    ? Text(
                  errorMessage.value,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.red,
                  ),
                )
                    : SizedBox.shrink(),
              ),
              SizedBox(height: 20.h),
              // Send button
              GestureDetector(
                onTap: () {
                  String email = emailController.text.trim();
                  if (email.isEmpty || !GetUtils.isEmail(email)) {
                    errorMessage.value = 'Please enter a valid email address';
                  } else {
                    // Handle forgot password logic, e.g., sending a reset email
                    print('Sending reset link to $email');
                    // Optionally show a success message or close dialog
                    Get.back(); // Close the dialog after sending
                  }
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
                    'Send',
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
      );
    },
  );
}
