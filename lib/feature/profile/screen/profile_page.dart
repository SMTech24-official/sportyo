// profile_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/const/image_path.dart';
import '../controller/profile_controller.dart';
import '../widget/global_text_style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
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
              const SizedBox(height: 12),
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
              const SizedBox(height: 16),
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
              const SizedBox(height: 29),
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
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.blackColor, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.blackColor, width: 1.0),
                    ),
                  ),
                  style: const TextStyle(color: AppColors.blackColor),
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
                  controller: controller.dateofbirthController,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.blackColor, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.blackColor, width: 1.0),
                    ),
                  ),
                  style: const TextStyle(color: AppColors.blackColor),
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
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.blackColor, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.blackColor, width: 1.0),
                    ),
                  ),
                  value: null,
                  hint: const Text(
                    "Select Gender",
                    style: TextStyle(color: AppColors.blackColor),
                  ),
                  style: const TextStyle(color: AppColors.blackColor),
                  items: ['Man', 'Woman']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    controller.selectedGender.value = newValue.toString();
                  },
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
              const SizedBox(height: 8),
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
                child: _buildLanguageField(controller),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.blackColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Incognito",
                          style: globalTextStyle(),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller
                                .toggle(); // Toggles between active and inactive states
                          },
                          child: Obx(
                            () => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 50, // Adjust based on your design
                              height: 25, // Adjust based on your design
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffE6E6E6),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  AnimatedPositioned(
                                    duration: const Duration(milliseconds: 200),
                                    left: controller.incognito.value ? 25 : 0,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xff404040),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          controller.incognito.value
                                              ? Icons.check
                                              : Icons.close,
                                          size: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageField(ProfileController controller) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.blackColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8.0,
              runSpacing: 5.0,
              children: controller.selectedLanguages.map((language) {
                return Chip(
                  label: Text(language),
                  deleteIcon: const Icon(Icons.close),
                  onDeleted: () {
                    controller.removeLanguage(language);
                  },
                );
              }).toList(),
            ),
            TextField(
              controller: controller.languageController,
              onChanged: (value) {
                controller.filterLanguages(value);
              },
              decoration: const InputDecoration(
                hintText: "Type a language",
                border: InputBorder.none,
              ),
            ),
            controller.filteredLanguages.isNotEmpty
                ? Container(
                    constraints: const BoxConstraints(maxHeight: 100),
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.filteredLanguages.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(controller.filteredLanguages[index]),
                            onTap: () {
                              controller.addLanguage(
                                  controller.filteredLanguages[index]);
                            },
                          );
                        },
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
