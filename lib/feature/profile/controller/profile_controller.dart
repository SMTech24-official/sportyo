import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  var imageFile = Rx<File?>(null);
  var userProfileImage = ''.obs;
  final List<String> languages = [
    // List of languages here...
  ];

  var filteredLanguages = <String>[].obs;
  var selectedLanguages = <String>[].obs;
  var selectedGender = ''.obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateofbirthController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  RxBool incognito = false.obs;
  RxBool genderRestriction = false.obs;
  RxString selectedSport = ''.obs;
  RxString selectedLevel = ''.obs;
  RxList<Map<String, String>> savedSports = <Map<String, String>>[].obs;
  RxInt editingIndex = (-1).obs;

  List<String> sports = [
    "Running",
    "Cycling",
    "Swimming",
    "Strength Training",
    "Hiking"
  ];
  List<String> levels = ["Beginner", "Intermediate", "Advanced", "Elite"];

  @override
  void onInit() {
    super.onInit();
    filteredLanguages.clear();
    languageController.addListener(() {
      filterLanguages(languageController.text);
    });

    fetchUserProfile();
  }

  void refreshdata() {
    nameController.clear();
    bioController.clear();
    dateofbirthController.clear();
    languageController.clear();
    selectedLanguages.clear();
    selectedGender.value = '';
    userProfileImage.value = '';
    incognito.value = false;
    genderRestriction.value = false;
    imageFile.value = null;

    // Clear saved sports and selections
    savedSports.clear();
    clearSelections();

    // Fetch profile data again
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      EasyLoading.show(status: 'Loading...');

      final url = Uri.parse(
          'https://sports-app-alpha.vercel.app/api/v1/users/66f537e7857b7a52a58718ab');

      final response = await http.get(
        url,
        headers: {
          'Authorization':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2ZjNmNjc3ZGE5ZWJlMDkyOTFiYTI1YiIsIm5hbWUiOiJyYWhhdCIsImVtYWlsIjoicmFoYXRAZ21haWwuY29tIiwicm9sZSI6IlVTRVIiLCJpYXQiOjE3MjcyNjQ0MzcsImV4cCI6MTcyOTg1NjQzN30.so5QOC6zUq3mGHhAt5zjAlaAz-ycbnSL2EMJ5QNpGdA',
        },
      );
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        if (jsonData['success'] == true) {
          var userData = jsonData['data'];

          // Update name if available
          if (userData['firstName'] != null &&
              userData['firstName'].isNotEmpty) {
            nameController.text = userData['firstName'];
          }

          // Update selected gender
          selectedGender.value = userData['gender'] ?? '';

          // Convert language string to list and assign
          if (userData['language'] != null && userData['language'].isNotEmpty) {
            selectedLanguages.assignAll(userData['language'].split(','));
          }

          // Update incognito and gender restriction status
          incognito.value = userData['incognito'] ?? false;
          genderRestriction.value = userData['genderRestriction'] ?? false;

          // Update bio if available
          if (userData['bio'] != null && userData['bio'].isNotEmpty) {
            bioController.text = userData['bio'];
          }

          // Update userProfileImage if not null or empty
          if (userData['profileImage'] != null &&
              userData['profileImage'].isNotEmpty) {
            userProfileImage.value = userData['profileImage'];
          }
        } else {
          EasyLoading.showError(jsonData['message']);
        }
      } else {
        EasyLoading.showError('Failed to load profile data');
      }
    } catch (e) {
      EasyLoading.showError('Failed to fetch user profile');
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  void filterLanguages(String query) {
    if (query.isEmpty) {
      filteredLanguages.clear();
    } else {
      filteredLanguages.assignAll(
        languages
            .where((language) =>
                language.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }

  // Add language to the selected list and clear input
  void addLanguage(String language) {
    if (!selectedLanguages.contains(language)) {
      selectedLanguages.add(language);
      languageController.clear();
      filteredLanguages.clear();
    }
  }

  // Remove a selected language
  void removeLanguage(String language) {
    selectedLanguages.remove(language);
  }

  // Incognito toggle
  void incognitoToggle() {
    incognito.value = !incognito.value;
  }

  // Gender restriction toggle
  void genderRestrictionToggle() {
    genderRestriction.value = !genderRestriction.value;
  }

  void saveSport() {
    if (selectedSport.isNotEmpty && selectedLevel.isNotEmpty) {
      if (editingIndex.value == -1) {
        // Add new sport
        savedSports
            .add({'sport': selectedSport.value, 'level': selectedLevel.value});
      } else {
        // Edit existing sport
        savedSports[editingIndex.value] = {
          'sport': selectedSport.value,
          'level': selectedLevel.value
        };
        editingIndex.value = -1;
      }
      clearSelections();
    }
  }

  void editSport(int index) {
    editingIndex.value = index;
    selectedSport.value = savedSports[index]['sport']!;
    selectedLevel.value = savedSports[index]['level']!;
  }

  void clearSelections() {
    selectedSport.value = '';
    selectedLevel.value = '';
    editingIndex.value = -1;
  }
}
