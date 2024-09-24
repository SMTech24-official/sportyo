import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sportyo/core/const/app_colors.dart';
import 'package:sportyo/core/const/app_texts.dart';
import 'package:sportyo/core/const/image_path.dart';
import 'package:sportyo/feature/event/controller/event_name_controller.dart';
import '../../../core/global_widegts/customTextField.dart';
import '../../profile/widget/global_text_style.dart';
import '../../search/screen/search_screen.dart';
import '../widgets/show_finish_time_dialog.dart';

class EventName extends StatelessWidget {
  EventName({super.key});
  final TextEditingController dateTEController = TextEditingController();
  final TextEditingController distanceTEController = TextEditingController();
  final EventNameController eventNameController =
      Get.find<EventNameController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) =>
          eventNameController.isValidate.value = false,
      canPop: true,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Event Name'),
          leading: GestureDetector(
            onTap: () {
              eventNameController.isValidate.value = false;
              Get.back();
            },
            child: Icon(
              size: 16.sp,
              Icons.arrow_back_ios,
              color: AppColors.blackColor,
            ),
          ),
        ),
        body: Obx(
          () {
            return eventNameController.isValidate.value == false
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            ImagePath.running,
                            height: 122.h,
                            width: 122.w,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'City',
                            style: globalTextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.center,
                                lineHeight: 23.sp / 16.sp),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Event Type',
                          style: globalTextStyle(lineHeight: 21.sp / 14.sp),
                        ),
                        SizedBox(height: 5.h),
                        Container(
                          alignment: Alignment.center,
                          width: 79.w,
                          height: 29.h,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r)),
                            border: Border.all(
                              color: const Color(0xFF010101),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'Running',
                            style: globalTextStyle(lineHeight: 21.sp / 14.sp),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Description',
                          style: globalTextStyle(lineHeight: 21.sp / 14.sp),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n'
                          'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n'
                          'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                          style: globalTextStyle(
                              fontWeight: FontWeight.w600,
                              lineHeight: 21.sp / 14.sp),
                        ),
                        SizedBox(height: 16.h),
                        SizedBox(
                          width: 153.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date',
                                style:
                                    globalTextStyle(lineHeight: 21.sp / 14.sp),
                              ),
                              SizedBox(height: 10.h),
                              CustomTextField(
                                textEditingController: dateTEController,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(
                          width: 153.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Distance',
                                style:
                                    globalTextStyle(lineHeight: 21.sp / 14.sp),
                              ),
                              SizedBox(height: 10.h),
                              CustomTextField(
                                textEditingController: distanceTEController,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              showFinishTImeDialog(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 281.w,
                              height: 60.h,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.r)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(10.h),
                                child: Text(
                                  'I would like to participate in this event with someone',
                                  style: globalTextStyle(
                                      lineHeight: 23.sp / 16.sp,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                      color: const Color(0xffFFFAFA)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            ImagePath.running,
                            height: 122.h,
                            width: 122.w,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'City',
                            style: globalTextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                textAlign: TextAlign.center,
                                lineHeight: 23.sp / 16.sp),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Event Type',
                          style: globalTextStyle(lineHeight: 21.sp / 14.sp),
                        ),
                        SizedBox(height: 5.h),
                        Container(
                          alignment: Alignment.center,
                          width: 79.w,
                          height: 29.h,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r)),
                            border: Border.all(
                              color: const Color(0xFF010101),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'Running',
                            style: globalTextStyle(lineHeight: 21.sp / 14.sp),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Description',
                          style: globalTextStyle(lineHeight: 21.sp / 14.sp),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n'
                          'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\n'
                          'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                          style: globalTextStyle(
                              fontWeight: FontWeight.w600,
                              lineHeight: 21.sp / 14.sp),
                        ),
                        SizedBox(height: 16.h),
                        SizedBox(
                          width: 153.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date',
                                style:
                                    globalTextStyle(lineHeight: 21.sp / 14.sp),
                              ),
                              SizedBox(height: 10.h),
                              CustomTextField(
                                textEditingController: dateTEController,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(
                          width: 153.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Distance',
                                style:
                                    globalTextStyle(lineHeight: 21.sp / 14.sp),
                              ),
                              SizedBox(height: 10.h),
                              CustomTextField(
                                textEditingController: distanceTEController,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const SearchScreen());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            height: 60.h,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.r)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.h),
                              child: Text(
                                'Find a Partner',
                                style: globalTextStyle(
                                    lineHeight: 24.sp / 16.sp,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 24.sp,
                                    color: const Color(0xffFFFAFA)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showFinishTImeDialog(context);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 118.w,
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.r)),
                                    border: Border.all(
                                      color: AppColors.primaryColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    'Edit',
                                    style: globalTextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        lineHeight: 22.sp / 16.sp),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 35.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 118.w,
                                  height: 35.h,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.r)),
                                    border: Border.all(
                                      color: AppColors.primaryColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    AppTexts.cancel,
                                    style: globalTextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        lineHeight: 22.sp / 16.sp),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
