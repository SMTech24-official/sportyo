import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/const/app_colors.dart';
import '../../../core/const/image_path.dart';
import '../../privacy_policy/privacy_policy.dart';
import '../controller/profile_controller.dart';
import '../widget/add_sports.dart';
import '../widget/confirm_delete_account.dart';
import '../widget/confirm_logout.dart';
import '../widget/global_text_style.dart';
import '../widget/language_filed.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            controller.refreshdata();
          },
          child: SingleChildScrollView(
            child: Form(
              key: controller.profileKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 11.h),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Edit profile",
                      style: globalTextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                        lineHeight: 1.5.h,
                        textAlign: TextAlign.center,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Align(
                    alignment: Alignment.center,
                    child: Obx(() {
                      return Container(
                        height: 120.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60.r),
                          image: DecorationImage(
                            image: controller.imageFile.value != null
                                ? FileImage(
                                    controller.imageFile.value!,
                                  ) as ImageProvider
                                : (controller.userProfileImage.value.isNotEmpty
                                    ? NetworkImage(
                                        controller.userProfileImage.value)
                                    : const AssetImage(ImagePath.profile)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 16.h),
                  InkWell(
                    onTap: () {
                      controller.pickImage();
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 32.h,
                        width: 134.w,
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
                  ),
                  SizedBox(height: 29.h),
                  Padding(
                    padding: EdgeInsets.only(left: 35.w),
                    child: Text(
                      "First Name",
                      style: globalTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: controller.firstnameController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: AppColors.blackColor, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: AppColors.blackColor, width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1.0),
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
                    padding: EdgeInsets.only(left: 35.w),
                    child: Text(
                      "Last Name",
                      style: globalTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: controller.lastnameController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: AppColors.blackColor, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: AppColors.blackColor, width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1.0),
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
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: controller.dateofbirthController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 15.0,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.blackColor,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: AppColors.blackColor,
                            width: 1.0,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1.0),
                        ),
                      ),
                      style: const TextStyle(color: AppColors.blackColor),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }

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
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Obx(
                      () => DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 15.0,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors.blackColor, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors.blackColor, width: 1.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 1.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Colors.red, width: 1.0),
                          ),
                        ),
                        value: controller.selectedGender.value.isEmpty
                            ? null
                            : controller.selectedGender.value,
                        hint: const Text(
                          "Select Gender",
                          style: TextStyle(color: AppColors.blackColor),
                        ),
                        style: const TextStyle(color: AppColors.blackColor),
                        items: ['man', 'women']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          controller.selectedGender.value = newValue!;
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a gender';
                          }
                          return null;
                        },
                      ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: buildLanguageField(controller),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.blackColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Incognito",
                              style: globalTextStyle(),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.incognitoToggle();
                              },
                              child: Obx(
                                () => AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: 50,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xffE6E6E6),
                                    border: Border.all(
                                        color: const Color(0xff737373)),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      AnimatedPositioned(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        left:
                                            controller.incognito.value ? 30 : 2,
                                        child: Container(
                                          width: 16,
                                          height: 16,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: const Color(0xff737373),
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
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 28.w),
                    child: Text(
                      "People can’t see your profile in the search and in events.",
                      style: globalTextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.blackColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Gender restriction",
                              style: globalTextStyle(),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.genderRestrictionToggle();
                              },
                              child: Obx(
                                () => AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: 50,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xffE6E6E6),
                                    border: Border.all(
                                        color: const Color(0xff737373)),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      AnimatedPositioned(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        left: controller.genderRestriction.value
                                            ? 30
                                            : 2,
                                        child: Container(
                                          width: 16,
                                          height: 16,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: const Color(0xff737373),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              controller.genderRestriction.value
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
                  ),
                  SizedBox(height: 5.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      "Make your profile visible only to people of your gender.",
                      style: globalTextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 37.w, right: 28.w),
                    child: Text(
                      "Bio",
                      style: globalTextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: controller.bioController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: AppColors.blackColor, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: AppColors.blackColor, width: 1.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1.0),
                        ),
                      ),
                      style: const TextStyle(color: AppColors.blackColor),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be empty';
                        } else if (value.length > 200) {
                          return 'Maximum 200 characters allowed';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 37.w, right: 28.w),
                    child: Text(
                      "My Sports",
                      style: globalTextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 37.w, right: 28.w),
                    child: Text(
                      "Add sports that you’re interested in along with your level.",
                      style: globalTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Obx(
                      () {
                        return controller.savedSports.isEmpty
                            ? const Center(
                                child: Text("add at least one sports"),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.savedSports.length,
                                itemBuilder: (context, index) {
                                  final sport = controller.savedSports[index];
                                  return InkWell(
                                    onTap: () {
                                      showAddSportDialog(context, sport: sport);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 13),
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: const Color(0xff010101),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 13),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("${sport.sportsName}"),
                                            Container(
                                              height: 25,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color:
                                                      const Color(0xff010101),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: Text("${sport.level}"),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: GestureDetector(
                      onTap: () {
                        showAddSportDialog(context);
                      },
                      child: Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                          color: const Color(0xff504949),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                            child: Icon(
                          Icons.add,
                          color: AppColors.whiteColor,
                        )),
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 37,
                      width: 107,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.updateUserProfile();
                        },
                        child: Text(
                          "Update",
                          style: globalTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 37,
                      width: 107,
                      child: ElevatedButton(
                        onPressed: () {
                          showConfirmLogoutDialog(context);
                        },
                        child: Text(
                          "Log out",
                          style: globalTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => PrivacyPolicy());
                      },
                      child: Text(
                        "Privacy Policy",
                        style: globalTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        showDeleteAccountDialog(context);
                      },
                      child: Text(
                        "Delete my account",
                        style: globalTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.redcolor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
