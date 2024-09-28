import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportyo/core/const/app_colors.dart';
import 'package:sportyo/core/const/app_texts.dart';
import '../controller/terms_and_condition.dart';


class TermsAndCondition extends StatelessWidget {
   TermsAndCondition({super.key});
   final TermsAndConditionController termsAndConditionController =Get.find<TermsAndConditionController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
      
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 25.h,
            ),
            Center(
              child: SizedBox(
                // height: 36.h,
                child: Text(
                  'Terms and Conditions',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sourceSans3(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    height: 39.87.sp / 28.sp,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 35.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 324.w,
                  child: Text(
                    'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sourceSans3(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      height: 22.7.sp / 16.sp,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 61.w,
                ),
                SizedBox(
                  height: 46.h,
                  width: 134.w,
                  child: ElevatedButton(
                      onPressed: termsAndConditionController.acceptButton,
                      child: Text(
                       AppTexts.accept,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sourceSans3(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            height: 30.sp / 20.sp,
                            color: AppColors.whiteColor),
                      )),
                ),
                SizedBox(
                  width: 28.w,
                ),
                SizedBox(
                  height: 46.h,
                  width: 134.w,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blackColor),
                      onPressed: () {
                       termsAndConditionController.isAccept.value=false;
                       Get.back();
                      },
                      child: Text(
                        AppTexts.decline,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sourceSans3(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            height: 30.sp / 20.sp,
                            color: AppColors.whiteColor),
                      )),
                ),
              ],
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
