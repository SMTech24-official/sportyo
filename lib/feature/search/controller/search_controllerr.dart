import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
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
    requestLocationAndSendToAPI();
    filteredUsers.value = List<Map<String, dynamic>>.from(users);
    searchController.addListener(() {
      ();
    });
  }

  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var city = '......'.obs;
  var isLoading = false.obs;

  Future<void> requestLocationAndSendToAPI() async {
    isLoading.value = true;

    // Step 1: Request location permission
    PermissionStatus permission = await Permission.location.request();

    if (permission.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            locationSettings:
                const LocationSettings(accuracy: LocationAccuracy.best));

        latitude.value = position.latitude;
        longitude.value = position.longitude;
        List<Placemark> placemarks = await placemarkFromCoordinates(
          latitude.value,
          longitude.value,
        );

        //Extract the city name
        if (placemarks.isNotEmpty) {
          city.value = placemarks.first.locality ?? 'Unknown';
          log("City: ${city.value}");
        } else {
          city.value = 'Unknown';
        }

        //Send location data to API
        await sendLocationToAPI(latitude.value, longitude.value, city.value);
      } catch (e) {
        log('Error getting location: $e');
      }
    } else {
      requestLocationAndSendToAPI();
      log('Location permission not granted');
    }
  }

  // Function to send the location data to your API
  Future<void> sendLocationToAPI(
      double latitude, double longitude, String city) async {
    log("long$longitude");
    log("lat$latitude");
    log("city$city");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var userId = prefs.getString("userId");
      final url = Uri.parse('${Urls.baseUrl}/users/$userId');

      Map<String, dynamic> requestBody = {
        "data": jsonEncode({
          "latitude": latitude,
          "longitude": longitude,
          "city": city.toString()
        }),
      };
      // Make the PUT request
      final response = await http.put(
        url,
        headers: {
          'Authorization': token.toString(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      log(response.body);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success']) {
          log('update sucessfully');
        } else {}
      } else {}
    } catch (e) {
      log('Error: $e');
    } finally {
      searchUser();
    }
  }

  void searchUser() async {
    isLoading.value = true;

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var userId = prefs.getString("userId"); // Fetch the current user's ID

      // Prepare the API URL with query parameters
      final url =
          Uri.parse('https://sports-app-alpha.vercel.app/api/v1/users/location')
              .replace(queryParameters: {
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
              'name': '${user.firstName} ${user.lastName}',
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
