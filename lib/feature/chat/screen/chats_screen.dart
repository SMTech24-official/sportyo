// lib/view/chat_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportyo/core/const/image_path.dart';

import '../controller/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  final String name;
  final String image;
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
    // Ensure the connection and joining room is done once after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatsController.connectToWebSocketAndJoinRoom(receiverId);
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
            chatsController.disconnectFromWebSocket();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: image.isEmpty || image == ''
                  ? const AssetImage(ImagePath.profile)
                  : NetworkImage(image),
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
      ),
      body: Column(
        children: [
          // Chat Messages List using Obx
          Expanded(
            child: Obx(() {
              if (chatsController.chatMessages.isEmpty) {
                return const Center(
                  child: Text('No messages yet'),
                );
              }

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
                        vertical: 6,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: message.isMe
                            ? Colors.blueAccent
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        message.content,
                        style: TextStyle(
                          color: message.isMe ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),

          // Message Input Field
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: chatsController.messageController,
                    onChanged: (text) {
                      chatsController.emitTyping();
                    },
                    decoration: const InputDecoration(
                      hintText: "Type a message",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.blueAccent,
                  onPressed: () {
                    if (chatsController.messageController.text
                        .trim()
                        .isNotEmpty) {
                      chatsController.sendMessage(
                        chatsController.messageController.text.trim(),
                        'YourUsername', // Replace 'YourUsername' with the actual sender name
                      );
                      chatsController.messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
