import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/service_class/network_caller/utility/usrls.dart';

class SearchsController extends GetxController {
  // Dummy user list
  var users = [].obs;

  // Filtered user list
  var filteredUsers = <Map<String, dynamic>>[].obs;

  // Search controller
  TextEditingController searchController = TextEditingController();

  // Filter properties
  var minAge = 18.obs;
  var maxAge = 80.obs;
  // Filtered user list
  List<String> sports = [
    "Running",
    "Cycling",
    "Swimming",
    "Strength Training",
    "Hiking"
  ];
  List<String> levels = ["Beginner", "Intermediate", "Advanced", "Elite"];

  // Filter properties
  var selectedSport = ''.obs;
  var selectedLevel = ''.obs;

  @override
  void onInit() {
    super.onInit();
    //requestLocationAndSendToAPI();
    searchUser();
    filteredUsers.value = List<Map<String, dynamic>>.from(users);
    searchController.addListener(() {
      ();
    });
  }

  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var city = '....'.obs;
  var isLoading = true.obs;

  void searchUser() async {
    isLoading.value = true;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var userId = prefs.getString("userId");
      city.value = prefs.getString("currentCity") ?? "....";

      // Prepare the API URL with query parameters
      final url =
          Uri.parse('${Urls.baseUrl}/users/location').replace(queryParameters: {
        'name': searchController.text,
        'ageRange': '${minAge.value}-${maxAge.value}',
        'level': selectedLevel.value,
        'sportsName': selectedSport.value,
      });

      // Make the GET request
      final response = await http.get(
        url,
        headers: {
          'Authorization': token.toString(),
          'Content-Type': 'application/json',
        },
      );
      log("response${response.body}");
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        if (jsonResponse['success']) {
          List<User> fetchedUsers = (jsonResponse['data'] as List)
              .map((userJson) => User.fromJson(userJson))
              .toList();

          // Update the filtered users with the retrieved data
          filteredUsers.value = fetchedUsers.where((user) {
            // Exclude the current user from the list
            return user.id != userId;
          }).map((user) {
            return {
              'id': user.id,
              'name': user.firstName,
              'age': user.age,
              'image': user.userProfileImage ?? '',
            };
          }).toList();
        } else {
          log('Error: ${jsonResponse['message']}');
        }
      } else {
        log('Failed to fetch users. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void refresh() {
    searchController.clear();
    minAge.value = 18;
    maxAge.value = 80;
    selectedSport.value = '';
    selectedLevel.value = '';
    searchUser();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String? userProfileImage;
  final int age;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.userProfileImage,
    required this.age,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      userProfileImage: json['userProfileImage'],
      age: json['age'],
    );
  }
}
