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
  var users = [
    {
      'id': 1,
      'name': 'Alice Johnson',
      'age': 25,
      'image':
          'https://img.freepik.com/free-photo/happy-business-man-standing-smiling-against-red-wall_155003-9367.jpg',
    },
    {
      'id': 2,
      'name': 'Bob Smith',
      'age': 30,
      'image':
          'https://img.freepik.com/free-photo/happy-business-man-standing-smiling-against-red-wall_155003-9367.jpg',
    },
    {
      'id': 3,
      'name': 'Charlie Brown',
      'age': 27,
      'image':
          'https://img.freepik.com/free-photo/happy-business-man-standing-smiling-against-red-wall_155003-9367.jpg',
    },
    {
      'id': 4,
      'name': 'Diana Prince',
      'age': 22,
      'image':
          'https://img.freepik.com/free-photo/happy-business-man-standing-smiling-against-red-wall_155003-9367.jpg',
    },
    {
      'id': 5,
      'name': 'Edward Kenway',
      'age': 35,
      'image':
          'https://img.freepik.com/free-photo/happy-business-man-standing-smiling-against-red-wall_155003-9367.jpg',
    },
    {
      'id': 6,
      'name': 'Fiona Gallagher',
      'age': 28,
      'image':
          'https://img.freepik.com/free-photo/happy-business-man-standing-smiling-against-red-wall_155003-9367.jpg',
    },
    {
      'id': 7,
      'name': 'George Clooney',
      'age': 31,
      'image':
          'https://img.freepik.com/free-photo/happy-business-man-standing-smiling-against-red-wall_155003-9367.jpg',
    },
    {
      'id': 8,
      'name': 'Hannah Montana',
      'age': 26,
      'image':
          'https://img.freepik.com/free-photo/happy-business-man-standing-smiling-against-red-wall_155003-9367.jpg',
    },
    {
      'id': 9,
      'name': 'Ian Malcolm',
      'age': 29,
      'image':
          'https://img.freepik.com/free-photo/happy-business-man-standing-smiling-against-red-wall_155003-9367.jpg',
    },
    {
      'id': 10,
      'name': 'Jessica Jones',
      'age': 24,
      'image':
          'https://img.freepik.com/free-photo/happy-business-man-standing-smiling-against-red-wall_155003-9367.jpg',
    },
  ].obs;

  // Filtered user list
  var filteredUsers = <Map<String, dynamic>>[].obs;

  // Search controller
  TextEditingController searchController = TextEditingController();

  // Filter properties
  var minAge = 18.obs;
  var maxAge = 50.obs;
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
      filterUsers();
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
        // Step 2: Get the current location with high accuracy
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
        );

        latitude.value = position.latitude;
        longitude.value = position.longitude;

        // Step 3: Get the city name from latitude and longitude
        List<Placemark> placemarks = await placemarkFromCoordinates(
          latitude.value,
          longitude.value,
        );

        // Step 4: Extract the city name
        if (placemarks.isNotEmpty) {
          city.value = placemarks.first.locality ?? 'Unknown';
          log("City: ${city.value}");
        } else {
          city.value = 'Unknown';
        }

        // Step 5: Send location data (latitude, longitude, city) to API
        await sendLocationToAPI(latitude.value, longitude.value, city.value);
      } catch (e) {
        log('Error getting location: $e');
      }
    } else {
      log('Location permission not granted');
    }

    isLoading.value = false;
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

      if (token != null && userId != null) {
        // Show loading indicator
        // Prepare the API URL
        final url = Uri.parse('${Urls.baseUrl}/users/$userId');

        // Prepare the request body as a stringified JSON for the data key
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
            'Authorization': token,
            'Content-Type': 'application/json',
          },
          body: jsonEncode(requestBody),
        );

        log(response.body);

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          if (jsonResponse['success']) {
          } else {}
        } else {}
      } else {}
    } catch (e) {
      log('Error: $e');
    } finally {}
  }

  void filterUsers() {
    // Start with the full list of users
    List<Map<String, dynamic>> tempList =
        List<Map<String, dynamic>>.from(users); // Correctly typed list

    // Remove users that don't match the age filter
    tempList.removeWhere((user) {
      return user['age'] < minAge.value || user['age'] > maxAge.value;
    });

    // Further filter based on the search query
    if (searchController.text.isNotEmpty) {
      tempList.retainWhere((user) {
        return user['name']
            .toString()
            .toLowerCase()
            .contains(searchController.text.toLowerCase());
      });
    }

    // Update the filtered list
    filteredUsers.value = tempList;
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
