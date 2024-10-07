import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportyo/core/service_class/network_caller/repository/second_Network_caller.dart';
import 'package:sportyo/feature/event/model/user_list_by_id.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/service_class/network_caller/utility/usrls.dart';

class FindPartnersForEventController extends GetxController {
  // Search controller
  TextEditingController searchController = TextEditingController();
  TextEditingController predictedTimeController = TextEditingController();
  TextEditingController timeRangeTEController = TextEditingController();
  final Rx<UserListByEventId> _userListById = UserListByEventId().obs;
  final RxList<Data> filteredParticipants = <Data>[].obs;
  Rx<UserListByEventId> get userListById => _userListById;

  Future<void> getEventListByEventId(String eventId) async {
    EasyLoading.show(status: "Loading...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    try {
      final response = await SecondNetworkCaller().getRequest(
          Urls.findPartnersByEvent(
            eventId,
          ),
          token: token);
      // Handle response success
      if (response.isSuccess) {
        _userListById.value = UserListByEventId.fromJson(response.responseData);
        filteredParticipants.assignAll(_userListById.value.data!);
      }
    } catch (error) {
      EasyLoading.showError('Failed to add event. Please try again.');
    } finally {
      EasyLoading.dismiss();
    }
  }

  // Filter participants by name
  void filterParticipantsByName(String searchQuery) {
    if (searchQuery.isEmpty) {
      filteredParticipants.assignAll(_userListById
          .value.data!); // Show all participants if search is cleared
    } else {
      final queryLower = searchQuery.toLowerCase();
      filteredParticipants.assignAll(
        _userListById.value.data!.where((participant) {
          final fullName =
              '${participant.firstName ?? ''} ${participant.lastName ?? ''}'
                  .toLowerCase();
          return fullName.contains(queryLower);
        }).toList(),
      );
    }
  }
  bool validatePredictedTime(String time) {
    final RegExp timeRegex = RegExp(r'^([01]\d|2[0-3]):([0-5]\d)$');
    return timeRegex.hasMatch(time);
  }
  Future<void> filterByPredictedTime(String eventId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    if (validatePredictedTime(predictedTimeController.text)) {
      EasyLoading.show(status: "Loading...");
      try {
        final response = await SecondNetworkCaller().getRequest(
          Urls.filterByPredictedTime(
            eventId, predictedTimeController.text.trim(),
          ),
          token: token,
        );

        // Handle response success
        if (response.isSuccess) {
          final filteredData = response.responseData['data']
              .map<Data>((json) => Data.fromJson(json))
              .toList();
          filteredParticipants.assignAll(filteredData);
          predictedTimeController.clear();
          Get.back();
        } else {
          EasyLoading.showError( 'No participants present at this time.');
        }
      } catch (error) {
        EasyLoading.showError('Failed to search event. Please try again.');
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
  Future<void> filterByPTimeRange(String eventId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    EasyLoading.show(status: "Loading...");
    try {
      final response = await SecondNetworkCaller().getRequest(
        Urls.filterByTimeRange(
          eventId, predictedTimeController.text.trim(),timeRangeTEController.text.trim()
        ),
        token: token,
      );
      // Handle response success
      if (response.isSuccess) {
        final filteredData = response.responseData['data']
            .map<Data>((json) => Data.fromJson(json))
            .toList();
        filteredParticipants.assignAll(filteredData);
        predictedTimeController.clear();
        timeRangeTEController.clear();
        Get.back();
      } else {
        EasyLoading.showError( 'No participants present at this time.');
      }
    } catch (error) {
      EasyLoading.showError('Failed to search event. Please try again.');
    } finally {
      EasyLoading.dismiss();
    }
  }


  @override
  void onClose() {
    searchController.dispose();
    timeRangeTEController.dispose();
    super.onClose();
  }
}
