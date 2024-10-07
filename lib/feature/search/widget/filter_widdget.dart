import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sportyo/core/global_widegts/custom_button_container.dart';
import 'package:sportyo/feature/profile/widget/global_text_style.dart';
import 'package:sportyo/feature/search/controller/search_controllerr.dart';

void showSearchFilterDialog(BuildContext context) {
  final SearchsController controller = Get.find();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        content: SingleChildScrollView(
          // Ensures scroll if content overflows
          child: SizedBox(
            width: 284.w, // Responsiveness for width
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(left: 91.w),
                  child: Text(
                    'Filter Partners',
                    style: globalTextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 21.h),
                Text(
                  "Sport",
                  style: globalTextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 35.h,
                  child: DropdownButtonFormField<String>(
                    value: controller.selectedSport.value.isEmpty
                        ? null
                        : controller.selectedSport.value,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    onChanged: (value) {
                      controller.selectedSport.value = value!;
                    },
                    items: controller.sports.map((sport) {
                      return DropdownMenuItem(
                        value: sport,
                        child: Text(sport),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Level",
                  style: globalTextStyle(fontSize: 14),
                ),
                SizedBox(
                  height: 35.h,
                  child: DropdownButtonFormField<String>(
                    value: controller.selectedLevel.value.isEmpty
                        ? null
                        : controller.selectedLevel.value,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    onChanged: (value) {
                      controller.selectedLevel.value = value!;
                    },
                    items: controller.levels.map((level) {
                      return DropdownMenuItem(
                        value: level,
                        child: Text(level),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 10.h),
                Obx(
                  () => Row(
                    children: [
                      Text(
                        'Age Range ',
                        style: globalTextStyle(fontSize: 14),
                      ),
                      Text(
                        "(${controller.minAge.value.toInt()} - ${controller.maxAge.value.toInt()})",
                        style: globalTextStyle(
                          color: const Color(0xff827E7E),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () {
                    return SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 1.0,
                      ),
                      child: RangeSlider(
                        values: RangeValues(
                          controller.minAge.value.toDouble(),
                          controller.maxAge.value.toDouble(),
                        ),
                        min: 18,
                        max: 99,
                        divisions: 81,
                        inactiveColor: const Color(0xff000000),
                        activeColor: const Color(0xff0D0C0C),
                        labels: RangeLabels(
                          '${controller.minAge.value.round()}',
                          '${controller.maxAge.value.round()}',
                        ),
                        onChanged: (values) {
                          controller.minAge.value = values.start.toInt();
                          controller.maxAge.value = values.end.toInt();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 20.h),
                CustomButtonContainer(
                  save: () {
                    controller.searchUser();
                    Get.back();
                  },
                  cancel: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
