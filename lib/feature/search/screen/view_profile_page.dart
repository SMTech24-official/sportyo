import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportyo/core/const/app_colors.dart';
import 'package:sportyo/feature/profile/widget/global_text_style.dart';

import '../controller/view_profile_controller.dart';

class PartnerDetailsPage extends StatelessWidget {
  const PartnerDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PrpfoleDetailsController controller =
        Get.put(PrpfoleDetailsController());
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Circular Image
              const Center(
                child: CircleAvatar(
                  radius: 75,
                  backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-photo/happy-business-man-standing-smiling-against-red-wall_155003-9367.jpg'),
                ),
              ),
              const SizedBox(height: 16),

              // Name and Age
              const Center(
                child: Text(
                  'Tom, Age 25',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    controller.startChat();
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${sport['sport']}"),
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
                                  child: Text("${sport['level']}"),
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'I’m an everyday person who enjoys life’s simple pleasures. I work hard, spend time with family, and like to relax with a good movie or book. I enjoy morning walks, local events, and helping neighbors when I can. I believe in kindness and staying positive.',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 24),

              // Languages Section
              const Text(
                'Languages',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      child: Text(
                        language,
                        style: globalTextStyle(fontSize: 12),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),

              // Location Section
              const Text(
                'Location',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'City XXX',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),

              // Upcoming Events Section
              const Text(
                'Upcoming Events',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // List of Upcoming Events
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.upcomingEvents.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Center(
                        child: Text(controller.upcomingEvents[index]),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
