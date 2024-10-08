import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sportyo/core/const/app_colors.dart';
import 'package:sportyo/core/const/app_texts.dart';
import 'package:sportyo/core/const/image_path.dart';
import 'package:sportyo/feature/authentication/auth_service/auth_service.dart';
import 'package:sportyo/feature/event/controller/event_details_controller.dart';
import '../../profile/widget/global_text_style.dart';
import '../model/event_model_class.dart';
import '../widgets/show_finish_time_dialog.dart';
import 'find_partners_for_event.dart';

class EventName extends StatelessWidget {
  final EventList event;
  EventName({super.key, required this.event});
  final EventNameController eventNameController =
      Get.find<EventNameController>();

  String getFormattedDate() {
    DateTime? eventDateTime;
    try {
      eventDateTime = DateTime.parse(event.date ?? '');
    } catch (e) {
      eventDateTime = null;
    }

    return eventDateTime != null
        ? DateFormat('dd/MM/yyyy').format(eventDateTime)
        : 'Date DD/MM/YYYY'; // Fallback if parsing fails
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = getFormattedDate();
    return PopScope(
      onPopInvokedWithResult: (didPop, result) =>
          eventNameController.resetValidation(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(event.eventName ?? 'Event Name'),
          leading: GestureDetector(
            onTap: () {
              eventNameController.resetValidation();
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
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Stack(children: [
                              Container(
                                height: 120.h,
                                width: 120.w,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(65.r)),
                                    color: const Color(0xffECE9E9)),
                              ),
                              Image.network(
                                event.eventImage ?? ImagePath.running,
                                height: 122.h,
                                width: 122.w,
                              ),
                            ]),
                          ),
                          SizedBox(height: 5.h),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              event.city ?? 'City',
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
                              event.sport ?? 'Running',
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
                            event.description ?? '',
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
                                  style: globalTextStyle(
                                      lineHeight: 21.sp / 14.sp),
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  alignment: Alignment.center,
                                  width: 100.w,
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
                                    formattedDate,
                                    style: globalTextStyle(
                                        lineHeight: 21.sp / 14.sp),
                                  ),
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
                                  style: globalTextStyle(
                                      lineHeight: 21.sp / 14.sp),
                                ),
                                SizedBox(height: 10.h),
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
                                    event.distance.toString(),
                                    style: globalTextStyle(
                                        lineHeight: 21.sp / 14.sp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: ()async {
                                // showFinishTimeDialog(
                                //     context, event.id ?? '', false);
                                bool hasComplete = await AuthService.profileComplete();
                                if (!context.mounted) return;
                                if(hasComplete){
                                  showFinishTimeDialog(context,event.id??'',false);
                                }else{
                                  Get.snackbar(
                                    'Empty Profile',
                                    'Please Completed Your Profile.',
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: AppColors.primaryColor,
                                    colorText: Colors.white,
                                  );
                                }
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
                          )
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Stack(children: [
                              Container(
                                height: 120.h,
                                width: 120.w,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(65.r)),
                                    color: const Color(0xffECE9E9)),
                              ),
                              Image.network(
                                event.eventImage ?? ImagePath.running,
                                height: 122.h,
                                width: 122.w,
                              ),
                            ]),
                          ),
                          SizedBox(height: 5.h),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              event.city ?? 'City',
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
                              event.sport ?? 'Running',
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
                            event.description ?? '',
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
                                  style: globalTextStyle(
                                      lineHeight: 21.sp / 14.sp),
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  alignment: Alignment.center,
                                  width: 100.w,
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
                                    formattedDate,
                                    style: globalTextStyle(
                                        lineHeight: 21.sp / 14.sp),
                                  ),
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
                                  style: globalTextStyle(
                                      lineHeight: 21.sp / 14.sp),
                                ),
                                SizedBox(height: 10.h),
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
                                    event.distance.toString(),
                                    style: globalTextStyle(
                                        lineHeight: 21.sp / 14.sp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => FindPartnersForEvent(event: event));
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
                                  'Find Partners for Event',
                                  style: globalTextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
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
                                    showFinishTimeDialog(
                                        context, event.id ?? '', true);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 118.w,
                                    height: 35.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.r)),
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
                                  width: 30.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    eventNameController
                                        .deleteData(event.id.toString());
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: 118.w,
                                    height: 35.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.r)),
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
                    ),
                  );
          },
        ),
      ),
    );
  }
}
