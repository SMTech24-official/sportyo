import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sportyo/core/const/app_colors.dart';
import 'package:sportyo/feature/profile/widget/global_text_style.dart';
import 'package:sportyo/feature/search/controller/search_controllerr.dart';

void showSearchFilterDialog(BuildContext context) {
  final SearchsController controller = Get.find();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: SizedBox(
          width: 284.w,
          height: 344.h,
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
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
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
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
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
                () => Text(
                  'Age Range: ${controller.minAge.value.toInt()} - ${controller.maxAge.value.toInt()}',
                  style: globalTextStyle(fontSize: 14),
                ),
              ),
              Obx(
                () {
                  return RangeSlider(
                    values: RangeValues(controller.minAge.value.toDouble(),
                        controller.maxAge.value.toDouble()),
                    min: 18,
                    max: 60,
                    divisions: 42,
                    labels: RangeLabels(
                      '${controller.minAge.value.round()}',
                      '${controller.maxAge.value.round()}',
                    ),
                    onChanged: (values) {
                      controller.minAge.value = values.start.toInt();
                      controller.maxAge.value = values.end.toInt();
                    },
                  );
                },
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 46.h,
                      width: 120.w,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.filterUsers();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Save',
                          style: globalTextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 46.h,
                      width: 120.w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.whiteColor,
                          side: BorderSide(color: AppColors.purplecolor),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                          style: globalTextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.purplecolor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
