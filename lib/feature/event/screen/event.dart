import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportyo/core/const/app_texts.dart';
import 'package:sportyo/core/const/icons_path.dart';
import 'package:sportyo/feature/event/screen/event_name.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/const/image_path.dart';
import '../../../core/global_widegts/customTextField.dart';
import '../controller/event_controller.dart';
import '../widgets/filter_dialog.dart';

class Event extends StatelessWidget {
  Event({super.key});

  final EventController eventController = Get.find<EventController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.events),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 58.w),
                child: CustomTextField(
                  hitText: 'Aa',
                  textEditingController:
                      eventController.searchController, // Bind to controller
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
          // Event list
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: ListView.separated(
                itemCount: 12,
                itemBuilder: (context, index) => eventListTile(onTap: () {
                  Get.to(() => EventName());
                }),
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget eventListTile({required VoidCallback onTap}) {
    return ListTile(
      leading: Image.asset(ImagePath.running, width: 50.w, height: 50.h),
      title: RichText(
        text: TextSpan(
          text: 'Event XX, ',
          style: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              height: 30.h / 20.h,
              color: AppColors.blackColor),
          children: [
            TextSpan(
              text: 'City',
              style: GoogleFonts.poppins(
                  fontSize: 20.sp,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  height: 30.h / 20.h,
                  color: AppColors.blackColor),
            ),
          ],
        ),
      ),
      subtitle: Text(
        'Date DD/MM/YY',
        style: GoogleFonts.poppins(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            height: 15.h / 10.h,
            color: const Color(0xff555151)),
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
