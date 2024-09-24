import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportyo/core/const/app_colors.dart';
import 'package:sportyo/core/const/icons_path.dart';
import 'package:sportyo/feature/chat/widget/report_user_dialouge.dart';
import 'package:sportyo/feature/profile/widget/global_text_style.dart';

import '../controller/chat_controller.dart';
import '../widget/delete_chat_dialouge.dart';

class ChatScreen extends StatelessWidget {
  final String name;
  final String image;
  final String chatId;

  ChatScreen({
    super.key,
    required this.name,
    required this.image,
    required this.chatId,
  });

  final ChatsController chatsController = Get.put(ChatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(image),
              radius: 20,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              deleteChatDialog(context);
            },
            child: Text(
              'Delete chat',
              style: globalTextStyle(
                fontSize: 12,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              reportUserDialog(context);
            },
            child: Text(
              'Report',
              style: globalTextStyle(fontSize: 12, color: AppColors.redcolor),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                controller: chatsController.scrollController,
                itemCount: chatsController.chatMessages.length,
                itemBuilder: (context, index) {
                  var message = chatsController.chatMessages[index];
                  return Align(
                    alignment: message.isMe
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color: message.isMe
                            ? const Color(0xFF6151F0)
                            : Colors.transparent,
                        border: Border.all(
                          color:
                              message.isMe ? Colors.transparent : Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        message.message,
                        style: TextStyle(
                          color: message.isMe ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: SizedBox(
                  height: 40,
                  child: TextField(
                    controller: chatsController.messageController,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      hintText: "Type a message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                )),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      color: AppColors.purplecolor,
                      borderRadius: BorderRadius.circular(17.5)),
                  child: Center(
                    child: IconButton(
                      icon: Image.asset(
                        IconsPath.sendButton,
                        height: 15,
                        width: 15,
                      ),
                      onPressed: () {
                        if (chatsController.messageController.text.isNotEmpty) {
                          chatsController.sendMessage(
                            chatsController.messageController.text,
                          );
                          chatsController.messageController.clear();
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
