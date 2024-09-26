import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindPartnersForEventController extends GetxController {
  // Search controller
  TextEditingController searchController = TextEditingController();

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
      'https://img.freepik.com/free-photo/astronaut-wearing-space-suit-earth_23-2151650707.jpg?t=st=1727326292~exp=1727329892~hmac=9d7a6a622b377162314cb8ee6edde0e3a92bfc2c0c7dea1eefe6f67bc99f582e&w=1380',
    },
  ].obs;

  // Filtered user list
  var filteredUsers = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    // Initialize filteredUsers with all users when the controller is initialized
    filteredUsers.assignAll(users);
    super.onInit();
  }

  // Function to filter users by name
  void searchUsers(String query) {
    if (query.isEmpty) {
      // If the search query is empty, show all users
      filteredUsers.assignAll(users);
    } else {
      // Filter users by name
      filteredUsers.assignAll(
        users.where((user) => user['name'].toString().toLowerCase().contains(query.toLowerCase())).toList(),
      );
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
