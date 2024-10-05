import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportyo/core/service_class/network_caller/repository/second_Network_caller.dart';
import 'package:sportyo/feature/event/model/user_list_by_id.dart';
import '../../../core/service_class/network_caller/utility/usrls.dart';

class FindPartnersForEventController extends GetxController {
  // Search controller
  TextEditingController searchController = TextEditingController();

  final Rx<UserListByEventId> _userListById = UserListByEventId().obs;
  final RxList<Data> filteredParticipants = <Data>[].obs;
  Rx<UserListByEventId> get userListById => _userListById;


  Future<void> getEventListByEventId(String eventId)async{
    EasyLoading.show(status: "Loading...");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");

    try {
      final response = await SecondNetworkCaller().getRequest(Urls.findPartnersByEvent(eventId,),token: token);
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
      filteredParticipants.assignAll(_userListById.value.data!); // Show all participants if search is cleared
    } else {
      final queryLower = searchQuery.toLowerCase();
      filteredParticipants.assignAll(
        _userListById.value.data!.where((participant) {
          final fullName = '${participant.firstName ?? ''} ${participant.lastName ?? ''}'.toLowerCase();
          return fullName.contains(queryLower);
        }).toList(),
      );
    }
  }
  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
