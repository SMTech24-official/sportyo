import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/const/app_colors.dart';
import '../controller/profile_edit_controller.dart';
import '../model/sports_model.dart';
import 'global_text_style.dart';

void showAddSportDialog(BuildContext context, {SportsDetail? sport}) {
  final ProfileController controller = Get.find();

  // If a sport is passed, set it for editing
  if (sport != null) {
    controller.selectedSport.value = sport.sportsName ?? '';
    controller.selectedLevel.value = sport.level ?? '';
    controller.editingIndex.value = controller.savedSports.indexOf(sport);
  } else {
    // Clear previous selections for adding new sport
    controller.clearSelections();
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: SizedBox(
          width: 284,
          height: 299,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 21.h),
              Padding(
                padding: EdgeInsets.only(left: 91.w),
                child: Text(
                  controller.editingIndex.value == -1
                      ? "Add a Sport"
                      : "Edit Sport",
                  style: globalTextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 21.h),
              Text(
                "Sport",
                style: globalTextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 35,
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
                height: 35,
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
              SizedBox(height: 43.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 56.h,
                      width: 120.w,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.addOrUpdateSport(context);
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
                      height: 56.h,
                      width: 120.w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.whiteColor,
                          side: BorderSide(color: AppColors.purplecolor),
                        ),
                        onPressed: () {
                          controller.clearSelections();
                          Get.back();
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
