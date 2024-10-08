import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sportyo/core/const/app_colors.dart';
import 'package:sportyo/core/const/icons_path.dart';
import 'package:sportyo/core/const/image_path.dart';
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
        title: const Text('Find Partners'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.refresh();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Obx(
                  () => RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: "My current location is ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: controller.city.value,
                          style: globalTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                            controller.searchUser();
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
                  return controller.isLoading.value
                      ? ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                height: 85.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            );
                          },
                        )
                      : controller.filteredUsers.isEmpty
                          ? ListView(
                              children: [
                                SizedBox(
                                  height: 300.h,
                                ),
                                const Align(
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
                                        backgroundImage:
                                            user['image'] == null ||
                                                    user['image'] == ''
                                                ? const AssetImage(
                                                    ImagePath.profile)
                                                : NetworkImage(user['image']),
                                        radius: 30,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          user['name'][0].toUpperCase() +
                                              user['name'].substring(1),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        "Age ${user['age']}",
                                        style: globalTextStyle(
                                          color: const Color(0xff94939A),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(
                                            () => UserDetailsPage(
                                                userId: user['id']),
                                          );
                                        },
                                        child: Container(
                                          height: 38,
                                          width: 85,
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
      ),
    );
  }
}
