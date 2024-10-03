import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sportyo/feature/event/screen/find_partners_for_event.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/service_class/network_caller/repository/network_caller.dart';
import '../../../core/service_class/network_caller/utility/usrls.dart';

class EventNameController extends GetxController {

  final TextEditingController predictedTimeController=TextEditingController();
  RxBool isValidate = false.obs;

  // Method to handle navigation logic
  void findPartner() {
    Get.to(()=>  FindPartnersForEvent());
  }
  // Method to validate the predicted time input
  bool validatePredictedTime(String time) {
    // Regular expression to match the HH:MM format
    final RegExp timeRegex = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$');
    return timeRegex.hasMatch(time);
  }
  // Method to handle validation logic
  void validateInput() {
    String predictedTime = predictedTimeController.text.trim();

    if (validatePredictedTime(predictedTime)) {
      isValidate.value = true;
      Get.back(); // Close the dialog after successful validation
    } else {
      // Show error message or dialog if the time format is incorrect
      Get.snackbar(
        'Invalid Input',
        'Please enter a valid time in HH:MM format.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor:  AppColors.primaryColor,
        colorText: Colors.white,
      );
    }

  }


  // Reset the validation state
  void resetValidation() {
    isValidate.value = false;
  }
  //dataLoad methods
  // final Rx<EventList> _eventList=EventList().obs;
  // Rx<EventList> get list=>_event;
  Future<void> featchEventNameData() async {
    EasyLoading.show(status: "Loading...");
    try {
      final response = await NetworkCaller().getRequest(Urls.sendEmail);

      if (response.isSuccess) {
        // _eventList.value = _eventList.fromJson(response.responseData);
      } else {
        EasyLoading.showError('Failed to load data');
      }
    } catch (error) {
      EasyLoading.showError('An error occurred: $error');
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  void dispose() {
    super.dispose();
    predictedTimeController.dispose();
  }
}
