import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportyo/feature/event/screen/find_partners_for_event.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/service_class/network_caller/repository/network_caller.dart';
import '../../../core/service_class/network_caller/utility/usrls.dart';

class EventNameController extends GetxController {

  final TextEditingController predictedTimeController=TextEditingController();
  RxBool isValidate = false.obs;


  // Method to validate the predicted time input
  bool validatePredictedTime(String time) {
    // Regular expression to match the HH:MM format
    final RegExp timeRegex = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$');
    return timeRegex.hasMatch(time);
  }

  Future<void> addEventName(String eventId)async{
    String predictedTime = predictedTimeController.text.trim();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.getString("userId");
    if (validatePredictedTime(predictedTime)) {
      try {
        EasyLoading.show(status: "Loading...");
        final Map<String, String> requestBody = {
          'eventId': eventId.toString(),
          'userId': userId.toString(),
          'joinedAt': predictedTime.toString(),
        };
        final response = await NetworkCaller().postRequest(Urls.addEvent,body: requestBody);


        // Handle response success
        if (response.isSuccess) {
          isValidate.value = true;
          EasyLoading.showSuccess('Event added successfully');
        }else{
          predictedTimeController.clear();
          EasyLoading.showError('You are already associated with this event');
        }
        Get.back();
      } catch (error) {
        EasyLoading.showError('Failed to add event. Please try again.');
      } finally {
        EasyLoading.dismiss();
      }
    } else {
      Get.snackbar(
        'Invalid Input',
        'Please enter a valid time in HH:MM format.',
        snackPosition: SnackPosition.TOP,
        backgroundColor:  AppColors.primaryColor,
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
    super.dispose();
    predictedTimeController.dispose();
  }
}
