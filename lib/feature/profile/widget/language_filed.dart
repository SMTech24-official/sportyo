import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportyo/feature/profile/widget/global_text_style.dart';
import '../../../core/const/app_colors.dart';
import '../controller/profile_edit_controller.dart';

Widget buildLanguageField(ProfileController controller) {
  return FormField<List<String>>(
    validator: (languages) {
      if (controller.selectedLanguages.isEmpty) {
        return "Please add at least one language";
      }
      return null;
    },
    builder: (formFieldState) {
      return Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.blackColor, width: 1.0),
                borderRadius: BorderRadius.circular(10.0),
                color: AppColors.whiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    
                    spacing: 8.0,
                    runSpacing: 5.0,
                    children: controller.selectedLanguages.map((language) {
                      return Chip(
                        backgroundColor: Colors.white,
                        label: Text(
                          language,
                          style: globalTextStyle(),
                        ),
                        deleteIcon: const Icon(Icons.close),
                        onDeleted: () {
                          controller.removeLanguage(language);
                          formFieldState.validate();
                        },
                      );
                    }).toList(),
                  ),
                  TextField(
                    controller: controller.languageController,
                    onChanged: (value) {
                      controller.filterLanguages(value);
                    },
                    decoration: InputDecoration(
                      hintText: "Type a language",
                      hintStyle: globalTextStyle(),
                      border: InputBorder.none,
                    ),
                  ),
                  controller.filteredLanguages.isNotEmpty
                      ? Container(
                          constraints: const BoxConstraints(maxHeight: 100),
                          margin: const EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.5)),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Obx(
                            () => ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.filteredLanguages.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    controller.filteredLanguages[index],
                                    style: globalTextStyle(),
                                  ),
                                  onTap: () {
                                    controller.addLanguage(
                                        controller.filteredLanguages[index]);
                                    controller.languageController.clear();
                                    controller.filterLanguages("");
                                    formFieldState.validate();
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
            if (formFieldState.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  formFieldState.errorText ?? "",
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      );
    },
  );
}
