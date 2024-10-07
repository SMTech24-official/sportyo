import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/service_class/network_caller/repository/network_caller.dart';
import '../../../core/service_class/network_caller/utility/usrls.dart';
import 'package:http/http.dart' as http;

class EventNameController extends GetxController {
  final TextEditingController predictedTimeController = TextEditingController();
  RxBool isValidate = false.obs;

  // Method to validate the predicted time input
  bool validatePredictedTime(String time) {
    // Regular expression to match the HH:MM format
    final RegExp timeRegex = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$');
    return timeRegex.hasMatch(time);
  }

  Future<void> addEventName(String eventId) async {
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
        final response =
            await NetworkCaller().postRequest(Urls.addEvent, body: requestBody);

        // Handle response success
        if (response.isSuccess) {
          // predictedTimeController.clear();
          isValidate.value = true;
          EasyLoading.showSuccess('Event added successfully');
        } else {
          if(response.statusCode==400){
            isValidate.value = true;
            // predictedTimeController.clear();
            EasyLoading.showError('You are already associated with this event');
          }

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
        backgroundColor: AppColors.primaryColor,
        colorText: Colors.white,
      );
    }
  }
  Future<void> deleteData(String eventId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    try {
      EasyLoading.show(status: "Loading...");
      final response = await http.delete(
        Uri.parse(Urls.deleteEvent(eventId)),
        headers: {
          'Authorization': token.toString(),
          'Content-type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Event deleted successfully');
        isValidate.value=false;
      } else {
        EasyLoading.showError('Failed to  Delete event. Please try again.');
      }
    } catch (e) {
      log(e.toString());
    }finally{
      EasyLoading.dismiss();
    }
  }

  Future<void> updateData(String eventId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    final Map<String, String> requestBody = {
      'joinedAt':predictedTimeController.text.trim(),
    };
    try {
      EasyLoading.show(status: "Loading...");
      final response = await http.put(
        Uri.parse(Urls.editEvent(eventId)),
        headers: {
          'Authorization': token.toString(),
          'Content-type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Event updated successfully');
        Get.back();
      } else {
        EasyLoading.showError('Failed to Update event. Please try again.');
      }
    } catch (e) {
     log(e.toString());
    }finally{
      EasyLoading.dismiss();
    }
  }
void checkProfile(){

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
