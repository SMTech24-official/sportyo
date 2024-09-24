import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sportyo/core/global_widegts/custom_button_container.dart';

import '../../../core/global_widegts/customTextField.dart';
import '../../profile/widget/global_text_style.dart';
import '../controller/event_name_controller.dart';

void showFinishTImeDialog(BuildContext context) {
final TextEditingController predictedTimeController=TextEditingController();
final EventNameController eventNameController=Get.find<EventNameController>();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        content: SizedBox(
          width: 284.w,
          height: 257.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'My Expected Finish Time',
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
                      hitText: 'Time in format HH:MM',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      lineHeight: 21.sp / 14.sp,
                      textEditingController:predictedTimeController,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50.h,

              ),
              // Save and Cancel buttons
              CustomButtonContainer(text:'Validate',save: () {
                eventNameController.isValidate.value=true;
                Get.back();
              }, cancel: () {  },)
            ],
          ),
        ),
      );
    },
  );
}