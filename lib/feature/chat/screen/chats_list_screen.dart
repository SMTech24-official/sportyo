import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sportyo/core/const/app_colors.dart';
import 'package:sportyo/feature/chat/controller/chat_list_controller.dart';
import 'package:sportyo/feature/profile/widget/global_text_style.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Your chats",
                style:
                    globalTextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: Obx(() {
                if (chatsController.chats.isEmpty) {
                  return Center(
                    child: Column(
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
                            // Navigate to Find Partners page
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
                          "Register for a race and find a race partner.",
                          style: globalTextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {},
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
                  );
                } else {
                  return ListView.separated(
                    itemCount: chatsController.chats.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: Color(0xffe8e8e8),
                      thickness: 1.0,
                      indent: 16,
                      endIndent: 16,
                    ),
                    itemBuilder: (context, index) {
                      final chat = chatsController.chats[index];
                      return SizedBox(
                        height: 70,
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 35,
                            backgroundImage: NetworkImage(chat.imageUrl),
                          ),
                          title: Text(chat.name),
                          subtitle: Text(
                            chat.lastMessage.length > 30
                                ? '${chat.lastMessage.substring(0, 30)}...'
                                : chat.lastMessage,
                          ),
                          onTap: () {
                            Get.to(
                              () => ChatScreen(
                                name: chat.name,
                                image: chat.imageUrl,
                                chatId: "5454151511",
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
