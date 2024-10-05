// lib/view/chat_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/const/app_colors.dart';
import '../../../core/const/icons_path.dart';
import '../controller/chat_controller.dart';
import '../widget/chat_screen_appbar.dart';

class ChatScreen extends StatelessWidget {
  final String name;
  final String image; // Used for AppBar avatar
  final String receiverId;

  ChatScreen({
    Key? key,
    required this.name,
    required this.image,
    required this.receiverId,
  }) : super(key: key);

  final ChatsController chatsController = Get.put(ChatsController());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatsController.connectToWebSocketAndJoinRoom(receiverId);
    });

    return Scaffold(
      appBar: CustomAppBar(
        name: name,
        image: image,
        chatsController: Get.find<ChatsController>(),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (chatsController.isLoading.value) {
                return ListView.builder(
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    bool isMe = index % 2 == 1;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 6.0,
                        horizontal: 12.0,
                      ),
                      child: Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: 230,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (chatsController.chatMessages.isEmpty) {
                return const Center(
                  child: Text(
                    'No messages yet',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: chatsController.scrollController,
                        itemCount: chatsController.chatMessages.length,
                        itemBuilder: (context, index) {
                          var message = chatsController.chatMessages[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 6.0,
                              horizontal: 12.0,
                            ),
                            child: Align(
                              alignment: message.isMe
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 230, // Max width constraint
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: message.isMe
                                        ? const Color(0xff6151f0)
                                        : const Color(0xfff8f7f7),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    message.content,
                                    style: TextStyle(
                                      color: message.isMe
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            }),
          ),

          // Message Input Field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                    child: SizedBox(
                  height: 40,
                  child: TextField(
                    controller: chatsController.messageController,
                    onChanged: (text) {
                      chatsController.emitTyping();
                    },
                    decoration: const InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
                        if (chatsController.messageController.text
                            .trim()
                            .isNotEmpty) {
                          chatsController.sendMessage(
                            chatsController.messageController.text.trim(),
                            name,
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
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
