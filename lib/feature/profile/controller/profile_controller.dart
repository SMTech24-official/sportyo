import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProfileController extends GetxController {
  // Reactive variables
  var selectedLanguages = <String>[].obs;
  var filteredLanguages = <String>[].obs;

  // TextEditingController for the language input
  TextEditingController textController = TextEditingController();

  // Method to add language to selected list
  void addLanguage(String language) {
    if (!selectedLanguages.contains(language)) {
      selectedLanguages.add(language);
      textController.clear(); // Clear the input after adding a language
      filteredLanguages.clear(); // Clear the dropdown list after selecting
    }
  }

  // Method to remove language from selected list
  void removeLanguage(String language) {
    selectedLanguages.remove(language);
  }

  // Filter languages based on input
  void filterLanguages(String query) {
    List<String> allLanguages = [
      // Add the complete list of languages here
      'English', 'Spanish', 'French', 'German', 'Chinese', 'Hindi', 'Arabic'
    ];

    if (query.isNotEmpty) {
      filteredLanguages.value = allLanguages
          .where((language) =>
              language.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } else {
      filteredLanguages.clear(); // Clear the list if query is empty
    }
  }

  @override
  void onClose() {
    textController
        .dispose(); // Dispose the controller when the screen is closed
    super.onClose();
  }
}
