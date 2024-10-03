import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sportyo/core/const/app_texts.dart';
import 'package:sportyo/core/const/icons_path.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/const/image_path.dart';
import '../../../core/global_widegts/customTextField.dart';
import '../../profile/widget/global_text_style.dart';
import '../controller/event_controller.dart';
import '../model/event_model_class.dart';
import '../widgets/filter_dialog.dart';

class Event extends StatelessWidget {
  Event({super.key});

  final EventController eventController = Get.find<EventController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            eventController.featchEventData();
          },
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Events",
                  style: globalTextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w600,
                    lineHeight: 1.5.h,
                    textAlign: TextAlign.center,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 58.w),
                    child: CustomTextField(
                      hitText: 'Search...',
                      textEditingController:
                      eventController.searchController,
                    ),
                  ),
                  SizedBox(width: 14.w),
                  InkWell(
                    onTap: () => showFilterDialog(context),
                    child: Image.asset(
                      IconsPath.filter,
                      height: 18.h,
                      width: 18.w,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 11.h),
              // Event list
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Obx(() {
                    if (eventController.filteredEventList.isEmpty) {
                      return const Center(
                        child: Text('No events found.'),
                      );
                    }
                    return ListView.separated(
                      itemCount: eventController.filteredEventList.length,
                      itemBuilder: (context, index) {
                        var event =
                        eventController.filteredEventList[index];
                        return eventListTile(
                          event: event,
                          onTap: () {
                            // Get.to(() => EventName(event: event)); // Navigate with event data
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget eventListTile({required EventList event, required VoidCallback onTap}) {
    DateTime? eventDateTime;
    try {
      eventDateTime = DateTime.parse(event.date ?? '');
    } catch (e) {}

    String formattedDate = eventDateTime != null
        ? DateFormat('dd/MM/yyyy').format(eventDateTime)
        : 'Date DD/MM/YYYY';

    return ListTile(
      leading: Image.network(
        event.eventImage ?? ImagePath.running,
        width: 50.w,
        height: 50.h,
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              '${event.eventName ?? 'Event'}, ',
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                height: 30.h / 18.h,
                color: AppColors.blackColor,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            event.city ?? 'City',
            style: GoogleFonts.poppins(
              fontSize: 18.sp,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              height: 30.h / 18.h,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
      subtitle: Text(
        'Date $formattedDate',
        style: GoogleFonts.poppins(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          height: 15.h / 10.h,
          color: const Color(0xff555151),
        ),
      ),
      trailing: SizedBox(
        height: 28.h,
        width: 78.w,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10.0.r),
            ),
            alignment: Alignment.center,
            child: Text(
              AppTexts.viewEvent,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                height: 17.h / 12.h,
                color: const Color(0xffFFFAFA),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

