import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:sportyo/core/const/app_colors.dart';
import 'package:sportyo/feature/chat/screen/chats_screen.dart';
import 'package:sportyo/feature/home/screen/home.dart';
import 'package:sportyo/feature/profile/widget/global_text_style.dart';

import '../../authentication/auth_service/auth_service.dart';
import '../model/profile_model.dart';

class UsersController extends GetxController {
  UsersController({required this.userId});

  final String userId;
  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  // Observable list for sports
  var sports = <SportsDetail>[].obs;

  // Observable list for languages
  var languages = <String>[].obs;

  // Observable variable for the user's age
  var age = 0.obs;

  var userModel = UserModel(
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
  ).obs;

  // Method to calculate the age
  int calculateAge(String dateOfBirth) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateTime dob = dateFormat.parse(dateOfBirth);
    DateTime currentDate = DateTime.now();

    int userAge = currentDate.year - dob.year;

    // Check if the birthday has occurred this year or not
    if (currentDate.month < dob.month ||
        (currentDate.month == dob.month && currentDate.day < dob.day)) {
      userAge--;
    }

    return userAge;
  }

  Future<void> fetchUserData() async {
    try {
      // Retrieve userId and token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');
      String? token = prefs.getString('token');

      if (userId == null || token == null) {
        return;
      }

      // API endpoint
      String url = 'https://sports-app-alpha.vercel.app/api/v1/users/$userId';

      // Making the HTTP GET request
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': token,
        },
      );
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        // Update the userModel with the data from the response
        userModel.value = UserModel.fromJson(jsonResponse['data']);

        // Update the sports observable list
        sports.value = userModel.value.sportsDetails;

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
        if (kDebugMode) {
          print('Failed to load user data: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {}
  }

  void startchat(String name, String image, String id, context) async {
    bool profileComplete = await AuthService.profileComplete();
    if (profileComplete) {
      Get.to(() => ChatScreen(name: name, image: image, receiverId: id));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.white,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Please fill your documents first",
                  style: globalTextStyle(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Get.offAll(() => Home());
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Fill Documents",
                    style: globalTextStyle(color: AppColors.whiteColor),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
