// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:sportyo/core/global_widegts/custom_button_container.dart';
// import '../../../core/global_widegts/customTextField.dart';
// import '../../profile/widget/global_text_style.dart';
// import '../controller/find_partners_for_event_controller.dart';
//
// void showFilterParticipants(BuildContext context) {
//  final FindPartnersForEventController controller=Get.find<FindPartnersForEventController>();
//
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.r),
//         ),
//         content: SizedBox(
//           width: 284.w,
//           height: 284.h,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Center(
//                 child: Text(
//                   'Filter Participants',
//                   style: globalTextStyle(
//                       fontSize: 20.sp, lineHeight: 30.sp / 20.sp),
//                 ),
//               ),
//               SizedBox(
//                 height: 20.h,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Predicted Time',
//                     style: globalTextStyle(
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   SizedBox(
//                     height: 35.h,
//                     width: double.infinity,
//                     child: CustomTextField(
//                       hitText: 'HH:MM',
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w400,
//                       lineHeight: 21.sp / 14.sp,
//                       textEditingController:controller.predictedTimeController,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Search Time Range',
//                     style: globalTextStyle(
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5.h,
//                   ),
//                   SizedBox(
//                     height: 35.h,
//                     width: double.infinity,
//                     child: CustomTextField(
//                       hitText: 'HH:MM',
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w400,
//                       lineHeight: 21.sp / 14.sp,
//                       textEditingController:controller.timeRangeTEController,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 40.h,
//               ),
//               // Save and Cancel buttons
//               CustomButtonContainer(save: () {
//
//                 Get.back();
//               }, cancel: () {  },)
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }