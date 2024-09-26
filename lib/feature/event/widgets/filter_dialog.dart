import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/const/app_texts.dart';
import '../../../core/global_widegts/customTextField.dart';
import '../../../core/global_widegts/custom_button_container.dart';
import '../../profile/widget/global_text_style.dart';
import '../controller/event_controller.dart';

void showFilterDialog(BuildContext context) {
  final EventController eventController =
      Get.find<EventController>();

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
                  AppTexts.filterEvents,
                  style: globalTextStyle(
                      fontSize: 20.sp, lineHeight: 30.sp / 20.sp),
                ),
              ),
              SizedBox(height: 5.h),
              // Country input field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppTexts.country,
                    style: globalTextStyle(
                        fontSize: 14.sp, lineHeight: 21.sp / 14.sp),
                  ),
                  SizedBox(
                    height: 35.h,
                    child: DropdownButtonFormField<String>(
                      padding: EdgeInsets.zero,
                      value: eventController.country.value.isEmpty
                          ? null
                          : eventController.country.value,
                      hint: Text(
                        'Select a Country',
                        style: globalTextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            lineHeight: 17.sp / 12.sp),
                      ),
                      items: eventController.countries.map((String country) {
                        return DropdownMenuItem<String>(
                          value: country,
                          child: Text(
                            country,
                            style: globalTextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                lineHeight: 17.sp / 12.sp),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          eventController.countryController.text = newValue;
                          eventController.country.value = newValue;
                        }
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 5.h, horizontal: 10.w),
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
                ],
              ),
              SizedBox(height: 10.h),
              // Sport input field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppTexts.sport,
                    style: globalTextStyle(
                        fontSize: 14.sp, lineHeight: 21.sp / 14.sp),
                  ),
                  SizedBox(
                    height: 35.h,
                    width: double.infinity,
                    child: CustomTextField(
                      hitText: 'Sport XX',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      lineHeight: 17.sp / 14.sp,
                      textEditingController: eventController.sportController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              // Event input field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppTexts.event,
                    style: globalTextStyle(
                        fontSize: 14.sp, lineHeight: 21.sp / 14.sp),
                  ),
                  SizedBox(
                    height: 35.h,
                    width: double.infinity,
                    child: CustomTextField(
                      hitText: 'Level XXX',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      lineHeight: 17.sp / 14.sp,
                      textEditingController: eventController.eventController,
                    ),
                  ),
                ],
              ),
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
                            textEditingController:
                                eventController.dateFromController,
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
                            textEditingController:
                                eventController.dateToController,
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
              // Save and Cancel buttons
              CustomButtonContainer(
                save: () {
                  eventController.clearFilters();
                  Get.back();
                },
                cancel: () {
                  Get.back();
                },
              )
            ],
          ),
        ),
      );
    },
  );
}


