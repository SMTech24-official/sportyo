import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportyo/core/const/app_colors.dart';
import 'package:sportyo/feature/profile/widget/global_text_style.dart';

import '../terms_and_condition/controller/terms_and_condition.dart';

class PrivacyPolicy extends StatelessWidget {
  PrivacyPolicy({super.key});
  final TermsAndConditionController termsAndConditionController =
      Get.find<TermsAndConditionController>();
  @override
  Widget build(BuildContext context) {
    termsAndConditionController.fetchTermsData();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'Privacy Policy',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 28.sp,
            fontWeight: FontWeight.w600,
            height: 39.87.sp / 28.sp,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 35.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 35.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(() {
                  if (termsAndConditionController.termsAndPolicy.value.policy !=
                      null) {
                    return Text(
                      termsAndConditionController.termsAndPolicy.value.policy ??
                          '',
                      textAlign: TextAlign.start,
                      style: globalTextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          lineHeight: 39.87.sp / 28.sp),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Center(
              child: SizedBox(
                height: 46.h,
                width: 134.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blackColor),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Close",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        height: 30.sp / 20.sp,
                        color: AppColors.whiteColor),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
          ],
        ),
      ),
    );
  }
}
