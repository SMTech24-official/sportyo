import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportyo/core/const/icons_path.dart';
import 'package:sportyo/core/global_widegts/customTextField.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/const/image_path.dart';
import '../../../core/global_widegts/authentication/custom_text_field.dart';

class Event extends StatelessWidget {
  Event({super.key});
  final TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
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
                padding: EdgeInsets.only(
                  left: 58.w,
                ),
                child: CustomTextField(
                    hitText: 'Aa', textEditingController: search),
              ),
              SizedBox(
                width: 14.w,
              ),
              Image.asset(
                IconsPath.filter,
                height: 16.h,
                width: 16.w,
              )
            ],
          ),
          // Event list
          Expanded(
            child: Padding(
              padding:  EdgeInsets.only(right: 8.w),
              child: ListView.separated(
                itemCount: 5,
                itemBuilder: (context, index) =>  eventSizeBox(ImagePath.running, 'Event XX', 'City', 'DD/MM/YY'), separatorBuilder: (BuildContext context, int index) {
                  return Divider();
              },

              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget eventSizeBox(
      String iconPath, String eventName, String city, String date) {
    return SizedBox(
      height: 87.h,
      width: double.infinity,
      child: ListTile(
        leading: Image.asset(iconPath, width: 50.h, height: 50.w),
        title: RichText(
          text: TextSpan(
            text: '$eventName, ',
            style: GoogleFonts.sourceSans3(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                height: 30.h / 20.h,
                color: AppColors.blackColor),
            children: [
              TextSpan(
                text: city,
                style: GoogleFonts.sourceSans3(
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
          'Date $date',
          style: GoogleFonts.sourceSans3(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              height: 15.h / 10.h,
              color: const Color(0xff555151)),
        ),
        trailing :SizedBox(
          height: 28.h,
          width: 78.w,
          child: GestureDetector(
            onTap: () {

            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              alignment: Alignment.center,
              child: Text(
                'View Event',
                textAlign: TextAlign.center,
                style: GoogleFonts.sourceSans3(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  height: 17.h / 12.h,
                  color: const Color(0xffFFFAFA),
                ),
              ),
            ),
          ),
        )
        ,
      ),
    );
  }
}
