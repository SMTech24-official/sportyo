import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import '../../../core/service_class/network_caller/utility/usrls.dart';
import '../../authentication/auth_service/auth_service.dart';
import '../../authentication/log_in/screen/log_in.dart';
import '../model/profile_model.dart';

class ProfileViewController extends GetxController {
  // ProfileViewController({required this.userId});

  // Observable list for sports and events
  var sports = <SportsDetail>[].obs;
  var events = <EventUser>[].obs;
  var languages = <String>[].obs;
  var age = 0.obs;

  var userModel = ProfileModel(
    id: '',
    email: '',
    userProfileImage: '',
    firstName: null,
    lastName: null,
    gender: '',
    dateOfBirth: '',
    bio: '',
    language: '',
    incognito: false,
    genderRestriction: false,
    role: '',
    userStatus: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    sportsDetails: [],
    eventUsers: [], // Initialize
  ).obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  // Method to calculate age
  int calculateAge(String dateOfBirth) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateTime dob = dateFormat.parse(dateOfBirth);
    DateTime currentDate = DateTime.now();

    int userAge = currentDate.year - dob.year;

    if (currentDate.month < dob.month ||
        (currentDate.month == dob.month && currentDate.day < dob.day)) {
      userAge--;
    }

    return userAge;
  }

  Future<void> fetchUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      String? userId = prefs.getString("userId");
      if (token == null) {
        return;
      }

      String url = 'https://sports-app-alpha.vercel.app/api/v1/users/$userId';
      var response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': token},
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        userModel.value = ProfileModel.fromJson(jsonResponse['data']);

        sports.value = userModel.value.sportsDetails;
        events.value = userModel.value.eventUsers;

        if (userModel.value.language.isNotEmpty) {
          languages.value = userModel.value.language
              .split(',')
              .map((lang) => lang.trim())
              .toList();
        } else {
          languages.clear();
        }

        if (userModel.value.dateOfBirth.isNotEmpty) {
          age.value = calculateAge(userModel.value.dateOfBirth);
        }
      } else {
        print('Failed to load user data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> deleteAccount() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var userId = prefs.getString("userId");

      if (token != null && userId != null) {
        // Show loading indicator
        EasyLoading.show(status: 'Deleting Profile...');

        // Prepare the API URL
        final url = Uri.parse('${Urls.baseUrl}/users/$userId/updateUserStatus');
        if (kDebugMode) {
          print(url);
        }
        // Prepare the request body
        Map<String, dynamic> requestBody = {"userStatus": "BLOCKED"};
        if (kDebugMode) {
          print(requestBody.toString());
        }
        // Make the PUT request
        final response = await http.put(
          url,
          headers: {
            'Authorization': token,
            'Content-Type': 'application/json',
          },
          body: jsonEncode(requestBody),
        );
        if (kDebugMode) {
          print(response.body);
        }
        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          if (jsonResponse['success']) {
            EasyLoading.showSuccess('Profile delete successfully!');
            AuthService.logoutUser();
          } else {
            EasyLoading.showError('Failed: ${jsonResponse['message']}');
          }
        } else {
          EasyLoading.showError('Failed to delete profile. Please try again.');
        }
      } else {
        EasyLoading.showError('Authentication failed. Please log in again.');
        Get.offAll(() => const LogIn());
      }
    } catch (e) {
      EasyLoading.showError('Something went wrong. Please try again.');
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      EasyLoading.dismiss();
    }
  }
}
