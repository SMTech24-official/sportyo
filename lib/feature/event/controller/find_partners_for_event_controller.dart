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
  Rx<UserListByEventId> get userListById => _userListById;
  Future<void> getEventListByEventId(String eventId)async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    EasyLoading.show(status: "Loading...");
    try {
      final response = await SecondNetworkCaller().getRequest(Urls.findPartnersByEvent(eventId,),token: token);
      // Handle response success
      if (response.isSuccess) {
        _userListById.value = UserListByEventId.fromJson(response.responseData);
      }
    } catch (error) {
      EasyLoading.showError('Failed to add event. Please try again.');
    } finally {
      EasyLoading.dismiss();
    }

  }
  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
