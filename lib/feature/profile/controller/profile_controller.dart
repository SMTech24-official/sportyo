// profile_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
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
  RxList<Map<String, String>> savedSports = <Map<String, String>>[].obs;
  RxInt editingIndex = (-1).obs; // -1 means no editing

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

  //incognito
  void incognitotoggle() {
    incognito.value = !incognito.value;
  }

  //genderRestriction
  void genderRestrictiontoggle() {
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
        editingIndex.value = -1; // Reset the editing index
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
    editingIndex.value = -1; // Reset the editing index
  }
}
