import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportyo/feature/event/screen/find_partners_for_event.dart';

class EventNameController extends GetxController {
  final TextEditingController dateTEController = TextEditingController();
  final TextEditingController distanceTEController = TextEditingController();
  final TextEditingController predictedTimeController=TextEditingController();
  RxBool isValidate = false.obs;

  // Method to handle navigation logic
  void findPartner() {
    Get.to(()=> const FindPartnersForEvent());
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
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }


  // Reset the validation state
  void resetValidation() {
    isValidate.value = false;
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dateTEController.dispose();
    distanceTEController.dispose();
    predictedTimeController.dispose();
  }
}
