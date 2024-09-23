import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportyo/core/global_widegts/customTextField.dart';

import '../../../core/const/app_colors.dart';
import '../../profile/widget/global_text_style.dart';

void showFilterDialog(BuildContext context) {
  final TextEditingController countryTEController = TextEditingController();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: SizedBox(
          width: 284.w,
          height: 415.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Filter Events",
                  style: globalTextStyle(
                      fontSize: 20.sp, lineHeight: 30.sp / 20.sp),
                ),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                height: 60.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Country",
                      style: globalTextStyle(
                          fontSize: 14.sp, lineHeight: 21.sp / 14.sp),
                    ),
                    SizedBox(
                      height: 35.h,
                      width: double.infinity,
                      child: CustomTextField(
                          hitText: 'Country XX',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          lineHeight: 17.sp / 12.sp,
                          textEditingController: countryTEController),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                height: 60.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sport",
                      style: globalTextStyle(
                          fontSize: 14.sp, lineHeight: 21.sp / 14.sp),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: CustomTextField(
                          hitText: 'Sport XXX',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          lineHeight: 17.sp / 12.sp,
                          textEditingController: countryTEController),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                height: 60.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Event",
                      style: globalTextStyle(
                          fontSize: 14.sp, lineHeight: 21.sp / 14.sp),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: CustomTextField(
                          hitText: 'Level XXX',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          lineHeight: 17.sp / 12.sp,
                          textEditingController: countryTEController),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 11.h),
              SizedBox(
                width: double.infinity,
                child: Text(
                  "Date",
                  style: globalTextStyle(
                      fontSize: 14.sp, lineHeight: 21.sp / 14.sp),
                ),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 113.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'From',
                            style: GoogleFonts.sourceSans3(
                                fontSize: 10.sp,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                height: 15.sp / 10.sp,
                                color: AppColors.blackColor),
                          ),
                          CustomTextField(
                            textEditingController: countryTEController,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 113.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TO',
                            style: GoogleFonts.sourceSans3(
                                fontSize: 10.sp,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                height: 15.sp / 10.sp,
                                color: AppColors.blackColor),
                          ),
                          CustomTextField(
                            textEditingController: countryTEController,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle Save button tap
                        },
                        child: Container(
                          height: 46.h,
                          width: 88.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors
                                .purplecolor, // Use your desired button color here
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Save',
                            style: globalTextStyle(
                              textAlign: TextAlign.center,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle Cancel button tap
                        },
                        child: Container(
                          height: 46.h,
                          width: 88.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor, // Background color
                            border: Border.all(
                                color: AppColors.purplecolor), // Border color
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Cancel',
                            style: globalTextStyle(
                              textAlign: TextAlign.center,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.purplecolor, // Text color
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
