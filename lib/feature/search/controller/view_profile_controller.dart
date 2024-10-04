import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import '../../../core/const/app_colors.dart';
import '../../authentication/auth_service/auth_service.dart';
import '../../chat/screen/chats_screen.dart';
import '../../home/screen/home.dart';
import '../../profile/widget/global_text_style.dart';
import '../model/profile_model.dart';

class UsersController extends GetxController {
  UsersController({required this.userId});

  final String userId;

  // Observable list for sports and events
  var sports = <SportsDetail>[].obs;
  var events = <EventUser>[].obs;
  var languages = <String>[].obs;
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
        userModel.value = UserModel.fromJson(jsonResponse['data']);

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
