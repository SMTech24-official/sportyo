import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    filteredUsers.value = List<Map<String, dynamic>>.from(users);
    searchController.addListener(() {
      filterUsers();
    });
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
