// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportyo/core/service_class/network_caller/utility/usrls.dart';
import 'package:sportyo/feature/authentication/log_in/screen/log_in.dart';

import '../model/sports_model.dart';

class ProfileController extends GetxController {
  final profileKey = GlobalKey<FormState>();
  //all list and variable
  var imageFile = Rx<File?>(null);
  var userProfileImage = ''.obs;
  final List<String> languages = [
    "Chinese",
    "Mandarin",
    "Spanish",
    "English",
    "Arabic",
    "Hindi",
    "Portuguese",
    "Bengali",
    "Brazilian Portuguese",
    "Russian",
    "Japanese",
    "Punjabi",
    "German",
    "Javanese",
    "Wu",
    "Malay",
    "Korean",
    "Vietnamese",
    "Telugu",
    "French",
    "Marathi",
    "Turkish",
    "Urdu",
    "Tamil",
    "Italian",
    "Cantonese",
    "Persian",
    "Gujarati",
    "Indonesian",
    "Bhojpuri",
    "Polish",
    "Kurdish Languages",
    "Pashto",
    "Kannada",
    "Sundanese",
    "Malayalam",
    "Maithili",
    "Hausa",
    "Odia",
    "Burmese",
    "Ukrainian",
    "Yoruba",
    "Tagalog",
    "Uzbek",
    "Fula",
    "Amharic",
    "Sindhi",
    "Igbo",
    "Romanian",
    "Oromo",
    "Azerbaijani",
    "Dutch",
    "Cebuano",
    "Thai",
    "Lao",
    "Serbo-Croatian",
    "Malagasy",
    "Nepalese",
    "Sinhala",
    "Khmer",
    "Taiwanese",
    "Swahili",
    "Madurese",
    "Somali",
    "Assamese",
    "Hungarian",
    "Greek",
    "Kazakh",
    "Zulu",
    "Afrikaans",
    "Haitian Creole",
    "Czech",
    "Ilokano",
    "Dari",
    "Swedish",
    "Quechua",
    "Kirundi",
    "Serbian",
    "Uyghur",
    "Hiligaynon",
    "Xhosa",
    "Albanian",
    "Catalan",
    "Belarusian",
    "Bulgarian",
    "Armenian",
    "Flemish",
    "Mongolian",
    "Danish",
    "Croatian",
    "Tatar",
    "Hebrew",
    "Slovak",
    "Finnish",
    "Norwegian",
    "Georgian",
    "Kyrgyz",
    "Wolof",
    "Lithuanian",
    "Hmong",
    "Bosnian",
    "Slovenian",
    "Macedonian",
    "Galician",
    "Latvian",
    "Yiddish",
    "Chechen",
    "Estonian",
    "Dinka",
    "Pangasinense",
    "Tibetan",
    "Sardinian",
    "Basque",
    "Maltese",
    "Welsh",
    "Luxembourgish",
    "Icelandic",
    "Tahitian",
    "Irish",
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
  RxList<SportsDetail> savedSports = <SportsDetail>[].obs;
  RxInt editingIndex = (-1).obs;

  //sports list given by clinet
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

  //redresh method for reload
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

  //fetch user details and show this in ui to edit or change
  Future<void> fetchUserProfile() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      if (kDebugMode) {
        print(token);
      }
      var userId = prefs.getString("userId");
      if (kDebugMode) {
        print(userId);
      }
      if (token!.isNotEmpty) {
        EasyLoading.show(status: 'Loading...');

        final url = Uri.parse('${Urls.baseUrl}/users/$userId');

        final response = await http.get(
          url,
          headers: {'Authorization': token},
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
            if (userData['dateOfBirth'] != null &&
                userData['dateOfBirth'].isNotEmpty) {
              dateofbirthController.text = userData['dateOfBirth'];
            }

            // Update selected gender
            selectedGender.value = userData['gender'] ?? '';

            // Convert language string to list and assign
            if (userData['language'] != null &&
                userData['language'].isNotEmpty) {
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
            if (userData['userProfileImage'] != null &&
                userData['userProfileImage'].isNotEmpty) {
              userProfileImage.value = userData['userProfileImage'];
            }
            if (userData['SportsDetails'] != null &&
                (userData['SportsDetails'] as List).isNotEmpty) {
              // Map the fetched sports data to the SportsDetail model
              savedSports.assignAll(
                (userData['SportsDetails'] as List)
                    .map((sportJson) => SportsDetail.fromJson(sportJson))
                    .toList(),
              );
            } else {
              savedSports.clear();
            }
          } else {
            EasyLoading.showError(jsonData['message']);
          }
        } else {
          EasyLoading.showError('Failed to load profile data');
        }
      } else {
        Get.offAll(() => const LogIn());
      }
    } catch (e) {
      EasyLoading.showError('Failed to fetch user profile');
    } finally {
      EasyLoading.dismiss();
      if (kDebugMode) {
        //print("Saved Sports: ${savedSports.toString()}");
      }
    }
  }

  //image picker method
  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  //filter languages from the language list for showing the suggetion
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

  //add or update sports
  void addOrUpdateSport(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var userId = prefs.getString("userId");

    if (selectedSport.isNotEmpty && selectedLevel.isNotEmpty) {
      // Show loading indicator
      EasyLoading.show(status: 'Loading...');

      // Prepare the request data
      String apiUrl = "${Urls.baseUrl}/sports";
      Map<String, dynamic> requestData = {
        "userId": userId,
        "sportsName": selectedSport.toString(),
        "level": selectedLevel.toString()
      };

      try {
        var response;

        // If editingIndex is -1, add new sport, otherwise update
        if (editingIndex.value == -1) {
          if (kDebugMode) {
            print("post");
          }
          // Add new sport (POST request)

          response = await http.post(
            Uri.parse(apiUrl),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': token.toString(),
            },
            body: jsonEncode(requestData),
          );
        } else {
          if (kDebugMode) {
            print("put");
          }
          // Update existing sport (PUT request)
          String sportId = savedSports[editingIndex.value].id!;
          String updateUrl = "$apiUrl/$sportId";

          response = await http.put(
            Uri.parse(updateUrl),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': token.toString(),
            },
            body: jsonEncode(requestData),
          );
        }

        if (kDebugMode) {
          print(response.body);
        }

        // Check if the response status is 200
        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.body);

          if (responseData['success'] == true) {
            selectedSport.value = '';
            selectedLevel.value = '';

            // If updating, update the existing sport in savedSports
            if (editingIndex.value != -1) {
              savedSports[editingIndex.value] =
                  SportsDetail.fromJson(responseData['data']);
            } else {
              // Add the new sport to savedSports
              savedSports.add(SportsDetail.fromJson(responseData['data']));
            }

            // Clear the form and reset editing index
            updateProfile();
            EasyLoading.showSuccess(responseData['message']);
            Get.back();
          } else {
            EasyLoading.showError('Failed: ${responseData['message']}');
          }
        } else {
          var responseData = jsonDecode(response.body);
          EasyLoading.showError('Failed: ${responseData['message']}');
        }
      } catch (e) {
        EasyLoading.showError('Something went wrong');
        if (kDebugMode) {
          print('Exception: $e');
        }
      } finally {
        EasyLoading.dismiss();
      }
    } else {
      EasyLoading.showError('Please select a sport and level');
    }
  }

  // Function to set sport for editing
  void setSportForEdit(int index) {
    selectedSport.value = savedSports[index].sportsName!;
    selectedLevel.value = savedSports[index].level!;
    editingIndex.value = index;
  }

  // Function to clear selection when canceling
  void clearSelections() {
    selectedSport.value = '';
    selectedLevel.value = '';
    editingIndex.value = -1;
  }

  //update sports list after add or edit
  Future<void> updateProfile() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      var userId = prefs.getString("userId");

      final url = Uri.parse('${Urls.baseUrl}/users/$userId');

      final response = await http.get(
        url,
        headers: {'Authorization': token.toString()},
      );
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        if (jsonData['success'] == true) {
          var userData = jsonData['data'];

          if (userData['SportsDetails'] != null &&
              (userData['SportsDetails'] as List).isNotEmpty) {
            // Map the fetched sports data to the SportsDetail model
            savedSports.assignAll(
              (userData['SportsDetails'] as List)
                  .map((sportJson) => SportsDetail.fromJson(sportJson))
                  .toList(),
            );
          } else {
            savedSports.clear();
          }
        } else {}
      } else {
        EasyLoading.showError('Failed to load profile data');
      }
    } catch (e) {
      EasyLoading.showError('Failed to update user profile');
    }
  }

  //update data method
  Future<void> updateUserProfile() async {
    if (kDebugMode) {
      print("ok");
    }
    if (profileKey.currentState!.validate()) {
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var token = prefs.getString("token");
        var userId = prefs.getString("userId");

        if (token != null && userId != null) {
          // Show loading indicator
          EasyLoading.show(status: 'Updating Profile...');

          // Prepare the API URL
          final url = Uri.parse('${Urls.baseUrl}/users/$userId');

          // Prepare the request body
          Map<String, dynamic> requestBody = {
            "firstName": nameController.text.trim(),
            "dateOfBirth": dateofbirthController.text.trim(),
            "gender": selectedGender.value,
            "language": selectedLanguages.join(','),
            "genderRestriction": genderRestriction.value,
            "incognito": incognito.value,
            "bio": bioController.text.trim(),
            // "userProfileImage": ""
            // "userProfileImage": imageFile.value != null
            //     ? base64Encode(imageFile.value!.readAsBytesSync())
            //     : null,
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
          if (kDebugMode) {
            print(response.body);
          }
          if (response.statusCode == 200) {
            var jsonResponse = jsonDecode(response.body);
            if (jsonResponse['success']) {
              EasyLoading.showSuccess('Profile updated successfully!');
              refreshdata();
            } else {
              EasyLoading.showError('Failed: ${jsonResponse['message']}');
            }
          } else {
            EasyLoading.showError(
                'Failed to update profile. Please try again.');
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
    } else {
      EasyLoading.showError('Please fill in all required fields.');
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
        final url = Uri.parse('${Urls.baseUrl}/users/$userId');

        // Prepare the request body
        Map<String, dynamic> requestBody = {
          "userStatus": "BLOCK",
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
        if (kDebugMode) {
          print(response.body);
        }
        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          if (jsonResponse['success']) {
            EasyLoading.showSuccess('Profile delete successfully!');
            //navigate to login page
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
