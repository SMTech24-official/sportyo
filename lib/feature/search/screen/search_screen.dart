import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sportyo/core/const/app_colors.dart';
import 'package:sportyo/core/const/icons_path.dart';
import 'package:sportyo/feature/profile/widget/global_text_style.dart';
import 'package:sportyo/feature/search/screen/view_profile_page.dart';

import '../controller/search_controllerr.dart';
import '../widget/filter_widdget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchsController controller = Get.put(SearchsController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Find Partners'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("My current location is "),
                Text(
                  "City XX",
                  style: globalTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 35.h,
                      child: TextFormField(
                        controller: controller.searchController,
                        onChanged: (value) {
                          controller.filterUsers();
                        },
                        decoration: InputDecoration(
                          hintText: 'Search Partners',
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () => showSearchFilterDialog(context),
                    icon: Image.asset(
                      IconsPath.filter,
                      height: 20,
                      width: 20,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                return controller.filteredUsers.isEmpty
                    ? ListView(
                        children: const [
                          Align(
                            alignment: Alignment.center,
                            child: Text("No user Found"),
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: controller.filteredUsers.length,
                        itemBuilder: (context, index) {
                          final user = controller.filteredUsers[index];
                          return Container(
                            height: 75,
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(user['image']),
                                  radius: 30,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    user['name'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text("Age ${user['age']}"),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => const PartnerDetailsPage());
                                  },
                                  child: Container(
                                    height: 38,
                                    width: 85,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "View Profile",
                                        style: globalTextStyle(
                                          color: AppColors.whiteColor,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
