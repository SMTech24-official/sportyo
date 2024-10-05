import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sportyo/core/const/app_colors.dart';
import 'package:sportyo/core/const/image_path.dart';
import 'package:sportyo/feature/event/screen/event.dart';
import 'package:sportyo/feature/profile/widget/global_text_style.dart';

import '../../search/screen/search_screen.dart';
import '../controller/chat_list_controller.dart';
import 'chats_screen.dart';

class ChatsListScreen extends StatelessWidget {
  const ChatsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ChatsListController chatsController = Get.put(ChatsListController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Connections",
          style: globalTextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: chatsController.fetchChatUsers,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your chats",
                    style: globalTextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () => chatsController.isLoading.value
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: ListView.builder(
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
                          ),
                        )
                      : chatsController.chatUsers.isEmpty
                          ? Center(
                              child: ListView(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Text(
                                        "You don’t have any connection yet.\nStart making connections now.",
                                        textAlign: TextAlign.center,
                                        style: globalTextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.to(() => const SearchScreen());
                                        },
                                        child: Text(
                                          'Find Partners',
                                          style: globalTextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.whiteColor),
                                        ),
                                      ),
                                      const SizedBox(height: 40),
                                      Text(
                                        "Register for a race and \n find a race partner.",
                                        style: globalTextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          Get.to(() => Event());
                                        },
                                        child: Text(
                                          'Check Events',
                                          style: globalTextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.whiteColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : ListView.separated(
                              itemCount: chatsController.chatUsers.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                color: Color(0xffe8e8e8),
                                thickness: 1.0,
                                indent: 16,
                                endIndent: 16,
                              ),
                              itemBuilder: (context, index) {
                                var chatUser = chatsController.chatUsers[index];

                                return SizedBox(
                                  height: 70,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 35,
                                      backgroundImage: chatUser
                                              .userProfileImage.isEmpty
                                          ? const AssetImage(ImagePath.profile)
                                          : NetworkImage(
                                              chatUser.userProfileImage),
                                    ),
                                    title: Text(
                                      '${chatUser.firstName} ${chatUser.lastName}',
                                      style: globalTextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      chatUser.lastMessageContent.isEmpty
                                          ? "start conversation"
                                          : chatUser.lastMessageContent.length >
                                                  30
                                              ? '${chatUser.lastMessageContent.substring(0, 30)}...'
                                              : chatUser.isOther
                                                  ? "You: ${chatUser.lastMessageContent}"
                                                  : chatUser.lastMessageContent,
                                      style: globalTextStyle(),
                                    ),
                                    onTap: () {
                                      Get.to(
                                        () => ChatScreen(
                                          name:
                                              '${chatUser.firstName} ${chatUser.lastName}',
                                          image: chatUser.userProfileImage,
                                          receiverId: chatUser.id,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
