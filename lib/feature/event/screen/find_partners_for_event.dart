import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/const/icons_path.dart';
import '../../profile/widget/global_text_style.dart';
import '../../search/controller/search_controllerr.dart';
import '../../search/screen/view_profile_page.dart';
import '../widgets/show_filter_participants.dart';

class FindPartnersForEvent extends StatelessWidget {
  const FindPartnersForEvent({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchsController controller = Get.put(SearchsController());
    return Scaffold(
      appBar: AppBar(leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          size: 16.sp,
          Icons.arrow_back_ios,
          color: AppColors.blackColor,
        ),
      ),
        title: const Text('Find Partners'),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Event XX",
                style: globalTextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    lineHeight: 33.sp/22.sp,
                    color: AppColors.primaryColor),
              ),
            ),
            SizedBox(height: 23.h,),
            Row(
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
                 SizedBox(width: 10.w),
                IconButton(
                  onPressed: () => showFilterParticipants(context),
                  icon: Image.asset(
                    IconsPath.filter,
                    height: 16.h,
                    width: 16.w,
                  ),
                ),
              ],
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
                      height: 55.h,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(user['image']),
                            radius: 20.r,
                          ),
                           SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              user['name'],
                              style: globalTextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w600,
                                lineHeight: 40.sp/28.sp
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text("Time",style: globalTextStyle(
                              fontSize: 18.sp,
                              color: const Color(0xff94939A
                              ),
                              fontWeight: FontWeight.w700,
                              lineHeight: 27.sp/18.sp
                          ),),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const PartnerDetailsPage());
                            },
                            child: Container(
                              height: 28.h,
                              width: 78.w,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "View Profile",
                                  style: globalTextStyle(
                                    textAlign: TextAlign.center,
                                    fontSize: 12.sp,
                                    lineHeight: 17.sp/12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xffFFFAFA
                                    ),

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