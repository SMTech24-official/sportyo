// profile_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
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
  RxBool incognito = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initially, don't show any suggestions
    filteredLanguages.clear();

    // Listen for changes in the languageController to automatically filter languages
    languageController.addListener(() {
      filterLanguages(languageController.text);
    });
  }

  // Filter languages based on the user's input
  void filterLanguages(String query) {
    if (query.isEmpty) {
      filteredLanguages.clear(); // No input, no suggestions
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
      languageController.clear(); // Clear input after adding a language
      filteredLanguages.clear(); // Clear suggestions
    }
  }

  // Remove a selected language
  void removeLanguage(String language) {
    selectedLanguages.remove(language);
  }

  void toggle() {
    incognito.value = !incognito.value;
  }
}
