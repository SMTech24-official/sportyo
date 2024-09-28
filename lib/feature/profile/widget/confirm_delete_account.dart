import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sportyo/feature/authentication/auth_service/auth_service.dart';

import '../../../core/const/app_colors.dart';
import 'global_text_style.dart';

void showDeleteAccountDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r), // Responsive border radius
        ),
        content: SizedBox(
          width: 284.w, // Adjusting width responsively
          height: 166.h, // Adjusting height responsively
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h), // Responsive height
              Text(
                "Are you sure that you would like to delete your account?",
                textAlign: TextAlign.center,
                style: globalTextStyle(fontSize: 16.sp),
              ),
              SizedBox(height: 35.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 56.h,
                      width: 120.w,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'No',
                          style: globalTextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 56.h,
                      width: 120.w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.whiteColor,
                          side: BorderSide(color: AppColors.purplecolor),
                        ),
                        onPressed: () {
                          AuthService.logoutUser();
                        },
                        child: Text(
                          'Yes',
                          style: globalTextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.purplecolor,
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
      );
    },
  );
}
