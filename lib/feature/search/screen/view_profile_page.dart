import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sportyo/core/const/app_colors.dart';
import 'package:sportyo/core/const/image_path.dart';
import 'package:sportyo/feature/profile/widget/global_text_style.dart';
import '../controller/view_profile_controller.dart';
import '../widget/profile_loading.dart';

class UserDetailsPage extends StatelessWidget {
  final String userId;
  const UserDetailsPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final UsersController controller = Get.put(UsersController(userId: userId));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Find Partners'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Obx(() => controller.userModel.value.id.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Circular Image (Using dynamic profile image)
                    Center(
                      child: CircleAvatar(
                        radius: 75,
                        backgroundImage:
                            controller.userModel.value.userProfileImage == '' ||
                                    controller
                                            .userModel.value.userProfileImage ==
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
                          style: GoogleFonts.sourceSans3(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: controller.userModel.value.firstName ?? '',
                            ),
                            // ignore: unnecessary_null_comparison
                            if (controller.userModel.value.dateOfBirth !=
                                    null &&
                                controller.userModel.value.dateOfBirth != '')
                              TextSpan(
                                text: ' , Age - ${controller.age} years',
                              ),
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // controller.startChat();
                        },
                        child: Text(
                          'Start a discussion',
                          style: globalTextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Sports Section
                    const Text(
                      'Sports',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'City XXX',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      'Upcoming Events',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            )
          : profileShimmerLoadingEffect()),
    );
  }
}
