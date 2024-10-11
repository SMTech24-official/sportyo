import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportyo/core/const/app_colors.dart';
import 'package:sportyo/core/const/image_path.dart';
import 'package:sportyo/feature/profile/controller/profile_controller.dart';
import 'package:sportyo/feature/profile/widget/confirm_logout.dart';
import 'package:sportyo/feature/profile/widget/global_text_style.dart';
import '../../privacy_policy/privacy_policy.dart';
import '../../search/widget/profile_loading.dart';
import '../widget/confirm_delete_account.dart';
import 'profile_edit.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({
    super.key,
  });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileViewController controller = Get.put(ProfileViewController());
  @override
  void initState() {
    super.initState();
    controller.fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('My Profile'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchUserData();
        },
        child: Obx(() => controller.userModel.value.id.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 75,
                          backgroundImage: controller
                                          .userModel.value.userProfileImage ==
                                      '' ||
                                  controller.userModel.value.userProfileImage ==
                                      null
                              ? const AssetImage(ImagePath.profile)
                              : NetworkImage(
                                  controller.userModel.value.userProfileImage
                                      .toString(),
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Name and Age
                      Center(
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    "${controller.userModel.value.firstName ?? ''}  ",
                              ),
                              TextSpan(
                                text: controller.userModel.value.lastName ?? '',
                              ),
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffe7e5fd)),
                          onPressed: () {
                            Get.to(() => const ProfileViewScreen());
                          },
                          child: Text(
                            'Edit Profile',
                            style: globalTextStyle(
                              color: AppColors.purplecolor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Sports Section
                      const Text(
                        'Sports',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),

                      // List of Sports
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.sports.length,
                        itemBuilder: (context, index) {
                          final sport = controller.sports[index];
                          return InkWell(
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 13),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(sport.sportsName),
                                    Container(
                                      height: 25,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xff010101),
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(sport.level),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 24),

                      // Biography Section
                      const Text(
                        'Bio',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        controller.userModel.value.bio.isNotEmpty
                            ? controller.userModel.value.bio
                            : 'No bio available',
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 24),

                      // Languages Section
                      const Text(
                        'Languages',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),

                      // List of Languages
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 5.0,
                        children: controller.languages.map((language) {
                          return Container(
                            height: 30,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 5),
                              child: Text(
                                language,
                                style: globalTextStyle(fontSize: 12),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),

                      // Location Section (Placeholder)
                      const Text(
                        'Location',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'City XXX',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: Platform.isIOS ? 50 : 40),
                      controller.events.isEmpty
                          ? const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "No Upcoming Events",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Upcoming Events',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.events.length,
                                  itemBuilder: (context, index) {
                                    final event =
                                        controller.events[index].event;
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      height: 40,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.blackColor),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                        child: Text(
                                          event.eventName,
                                          style: globalTextStyle(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 30.h,
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
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              )
            : profileShimmerLoadingEffect()),
      ),
    );
  }
}
