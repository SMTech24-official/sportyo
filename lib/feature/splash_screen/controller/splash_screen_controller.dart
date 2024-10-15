import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../core/service_class/network_caller/utility/usrls.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  var userModel = ProfileModels(
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
    eventUsers: [],
  ).obs;

  Future<void> fetchUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      String? userId = prefs.getString("userId");
      if (token == null) {
        return;
      }

      String url = '${Urls.baseUrl}/users/$userId';
      var response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': token},
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        userModel.value = ProfileModels.fromJson(jsonResponse['data']);
      } else {
        if (kDebugMode) {
          print('Failed to load user data: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    } finally {
      if (kDebugMode) {
        print(userModel.value.toString());
      }
    }
  }
}

//model
class ProfileModels {
  String id;
  String email;
  String? userProfileImage;
  String? firstName;
  String? lastName;
  String gender;
  String dateOfBirth;
  String bio;
  String language;
  bool incognito;
  bool genderRestriction;
  String role;
  String userStatus;
  DateTime createdAt;
  DateTime updatedAt;
  List<SportsDetail> sportsDetails;
  List<EventUser> eventUsers;
  ProfileModels({
    required this.id,
    required this.email,
    this.userProfileImage,
    this.firstName,
    this.lastName,
    required this.gender,
    required this.dateOfBirth,
    required this.bio,
    required this.language,
    required this.incognito,
    required this.genderRestriction,
    required this.role,
    required this.userStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.sportsDetails,
    required this.eventUsers,
  });

  factory ProfileModels.fromJson(Map<String, dynamic> json) {
    return ProfileModels(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      userProfileImage: json['userProfileImage'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      bio: json['bio'] ?? '',
      language: json['language'] ?? '',
      incognito: json['incognito'] ?? false,
      genderRestriction: json['genderRestriction'] ?? false,
      role: json['role'] ?? '',
      userStatus: json['userStatus'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toString()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toString()),
      sportsDetails: (json['SportsDetails'] as List)
          .map((item) => SportsDetail.fromJson(item))
          .toList(),
      eventUsers: (json['EventUser'] as List)
          .map((item) => EventUser.fromJson(item))
          .toList(), // Handling events data
    );
  }
}

class SportsDetail {
  String id;
  String sportsName;
  String level;

  SportsDetail({
    required this.id,
    required this.sportsName,
    required this.level,
  });

  factory SportsDetail.fromJson(Map<String, dynamic> json) {
    return SportsDetail(
      id: json['id'] ?? '',
      sportsName: json['sportsName'] ?? '',
      level: json['level'] ?? '',
    );
  }
}

// New EventUser class
class EventUser {
  Event event;

  EventUser({required this.event});

  factory EventUser.fromJson(Map<String, dynamic> json) {
    return EventUser(
      event: Event.fromJson(json['event']),
    );
  }
}

class Event {
  String eventName;
  String city;
  String country;
  DateTime date; // Change this to DateTime

  Event({
    required this.eventName,
    required this.city,
    required this.country,
    required this.date,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventName: json['eventName'] ?? '',
      city: json['city'] ?? '',
      country: json['country'] ?? '',
      date: DateTime.parse(json['date']), // Parse directly to DateTime
    );
  }
}
