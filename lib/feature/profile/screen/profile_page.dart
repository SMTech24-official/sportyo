import 'package:flutter/material.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/const/image_path.dart';
import '../widget/global_text_style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<String> _languages = [
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
    "Irish"
  ];
  List<String> _filteredLanguages = [];
  List<String> _selectedLanguages = [];
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredLanguages = _languages;
  }

  void _filterLanguages(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredLanguages = [];
      } else {
        _filteredLanguages = _languages
            .where((language) =>
                language.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                "Edit profile",
                style: globalTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  lineHeight: 1.5,
                  textAlign: TextAlign.center,
                  color: AppColors.blackColor,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  image: const DecorationImage(
                    image: AssetImage(ImagePath.profile),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 32,
                width: 134,
                decoration: BoxDecoration(
                  color: AppColors.purplecolor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Update Photo",
                    style: globalTextStyle(
                      fontSize: 14,
                      color: AppColors.purplecolor,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 29,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Text(
                "First Name",
                style: globalTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.blackColor, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.blackColor, width: 1.0),
                  ),
                ),
                style: TextStyle(color: AppColors.blackColor),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Text(
                "Date of Birth",
                style: globalTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.blackColor, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.blackColor, width: 1.0),
                  ),
                ),
                style: TextStyle(color: AppColors.blackColor),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }

                  // Regular expression to validate date format dd/MM/yyyy
                  RegExp dateFormat = RegExp(
                      r'^([0-2][0-9]|(3)[0-1])\/([0]?[1-9]|1[0-2])\/\d{4}$');

                  if (!dateFormat.hasMatch(value)) {
                    return 'Please enter a valid date (dd/MM/yyyy)';
                  }

                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Text(
                "Gender",
                style: globalTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 15.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.blackColor, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.blackColor, width: 1.0),
                  ),
                ),
                value: null,
                hint: Text(
                  "Select Gender",
                  style: TextStyle(color: AppColors.blackColor),
                ),
                style: TextStyle(color: AppColors.blackColor),
                items: ['Man', 'Woman']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {},
                validator: (value) {
                  if (value == null) {
                    return 'Please select a gender';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Text(
                "Languages",
                style: globalTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 1.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display selected languages as chips
                    Wrap(
                      spacing: 8.0, // Space between language containers
                      runSpacing: 5.0, // Space between rows of containers
                      children: _selectedLanguages
                          .map((language) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 1.0),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height:
                                    30.0, // Adjust the height to match the design
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      language,
                                      style: const TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                    const SizedBox(width: 5),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedLanguages.remove(language);
                                        });
                                      },
                                      child: const Icon(
                                        Icons.close,
                                        size: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),

                    // The input field to type and search for languages
                    TextField(
                      controller: _textController,
                      onChanged: (value) {
                        setState(() {
                          _filterLanguages(
                              value); // Filter languages based on input
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: "Type a language",
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),

                    // Only show suggestions when the user types something
                    if (_textController.text.isNotEmpty &&
                        _filteredLanguages.isNotEmpty)
                      Container(
                        constraints: const BoxConstraints(
                            maxHeight: 100), // Limit the height of dropdown
                        margin: const EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.black.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _filteredLanguages.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                _filteredLanguages[index],
                                style: const TextStyle(color: Colors.black),
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedLanguages
                                      .add(_filteredLanguages[index]);
                                  _textController
                                      .clear(); // Clear input after selection
                                  _filterLanguages(
                                      ''); // Reset filter to show full list
                                });
                              },
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
