
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sportyo/feature/event/model/event_model_class.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/const/icons_path.dart';
import '../../../core/global_widegts/customTextField.dart';
import '../../../core/global_widegts/custom_button_container.dart';
import '../../profile/widget/global_text_style.dart';
import '../../search/screen/view_profile_page.dart';
import '../controller/find_partners_for_event_controller.dart';

class FindPartnersForEvent extends StatelessWidget {
  final EventList event;
  FindPartnersForEvent({super.key, required this.event});
  final FindPartnersForEventController controller =
      Get.find<FindPartnersForEventController>();

  @override
  Widget build(BuildContext context) {
    controller.getEventListByEventId(event.id.toString());
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            size: 16.sp,
            Icons.arrow_back_ios,
            color: AppColors.blackColor,
          ),
        ),
        title: const Text('Find Partners'),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.getEventListByEventId(event.id.toString()),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  event.eventName.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: globalTextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    lineHeight: 33.sp / 22.sp,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(height: 23.h),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 35.h,
                      child: TextFormField(
                        controller: controller.searchController,
                        onChanged: (value) {
                          controller.filterParticipantsByName(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search Partners',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  IconButton(
                    onPressed: () => showFilterParticipants(context,event.id.toString()),
                    icon: Image.asset(
                      IconsPath.filter,
                      height: 16.h,
                      width: 16.w,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Obx(() {
                if (controller.filteredParticipants.isEmpty) {
                  return Expanded(
                    child: Center(
                      child: Text(
                        "No participants available.",
                        style: globalTextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  );
                }
                final participants = controller.userListById.value.data!;
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.filteredParticipants.length,
                    itemBuilder: (context, index) {
                      final participant =
                          controller.filteredParticipants[index];
                      final DateTime joinedAtDateTime =
                          DateTime.parse(participant.joinedAt!);
                      final String formattedTime =
                          DateFormat('HH:mm').format(joinedAtDateTime);
                      return Container(
                        height: 55.h,
                        margin: EdgeInsets.symmetric(vertical: 5.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: participant.userProfileImage !=
                                      null
                                  ? NetworkImage(participant.userProfileImage!)
                                  : null, // Fallback to local asset
                              radius: 20.r,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: Text(
                                toBeginningOfSentenceCase('${participant.firstName}') ?? '',
                                style: globalTextStyle(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w600,
                                  lineHeight: 40.sp / 28.sp,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              formattedTime,
                              style: globalTextStyle(
                                fontSize: 18.sp,
                                color: const Color(0xff94939A),
                                fontWeight: FontWeight.w700,
                                lineHeight: 27.sp / 18.sp,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => UserDetailsPage(
                                      userId: participant.userId.toString(),
                                    ));
                              },
                              child: Container(
                                height: 28.h,
                                width: 88.w,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    "View Profile",
                                    style: globalTextStyle(
                                      textAlign: TextAlign.center,
                                      fontSize: 12.sp,
                                      lineHeight: 17.sp / 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xffFFFAFA),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
  void showFilterParticipants(BuildContext context,String eventId) {
    final FindPartnersForEventController controller=Get.find<FindPartnersForEventController>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          content: SizedBox(
            width: 284.w,
            height: 284.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Filter Participants',
                    style: globalTextStyle(
                        fontSize: 20.sp, lineHeight: 30.sp / 20.sp),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Predicted Time',
                      style: globalTextStyle(
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      height: 35.h,
                      width: double.infinity,
                      child: CustomTextField(
                        hitText: 'HH:MM',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        lineHeight: 21.sp / 14.sp,
                        textEditingController:controller.predictedTimeController,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Search Time Range',
                      style: globalTextStyle(
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      height: 35.h,
                      width: double.infinity,
                      child: CustomTextField(
                        hitText: 'Enter Range',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        lineHeight: 21.sp / 14.sp,
                        textEditingController:controller.timeRangeTEController,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),
                // Save and Cancel buttons
                CustomButtonContainer(save: () {

                  if(controller.timeRangeTEController.text.isEmpty){
                    controller.filterByPredictedTime(eventId);
                  }else{
                   controller.filterByPTimeRange(eventId);
                  }



                }, cancel: () {
                  Get.back();
                },)
              ],
            ),
          ),
        );
      },
    );
  }
}
