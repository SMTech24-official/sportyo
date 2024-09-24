import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/chat_model.dart';

class ChatsController extends GetxController {
  var messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  // Dummy chat list
  var chatMessages = <ChatMessage>[
    ChatMessage(
      messageId: '1',
      senderId: '101',
      receiverId: '102',
      message: 'Hello!',
      isRead: true,
      isMe: false,
    ),
    ChatMessage(
      messageId: '2',
      senderId: '102',
      receiverId: '101',
      message: 'Hi, how are you?',
      isRead: true,
      isMe: true,
    ),
    ChatMessage(
      messageId: '3',
      senderId: '101',
      receiverId: '102',
      message: 'I am good, thank you.',
      isRead: true,
      isMe: false,
    ),
    ChatMessage(
      messageId: '4',
      senderId: '102',
      receiverId: '101',
      message: 'What about you?',
      isRead: true,
      isMe: true,
    ),
    ChatMessage(
      messageId: '5',
      senderId: '101',
      receiverId: '102',
      message: 'I am doing great! Been busy with work.',
      isRead: true,
      isMe: false,
    ),
    ChatMessage(
      messageId: '6',
      senderId: '102',
      receiverId: '101',
      message: 'That’s good to hear. Are you free this weekend?',
      isRead: true,
      isMe: true,
    ),
    ChatMessage(
      messageId: '7',
      senderId: '101',
      receiverId: '102',
      message: 'Yes, I am. Do you have any plans?',
      isRead: true,
      isMe: false,
    ),
    ChatMessage(
      messageId: '8',
      senderId: '102',
      receiverId: '101',
      message: 'I was thinking of going for a hike. Want to join?',
      isRead: true,
      isMe: true,
    ),
    ChatMessage(
      messageId: '9',
      senderId: '101',
      receiverId: '102',
      message: 'That sounds like fun! Count me in.',
      isRead: true,
      isMe: false,
    ),
    ChatMessage(
      messageId: '10',
      senderId: '102',
      receiverId: '101',
      message: 'Great! I’ll send you the details later.',
      isRead: true,
      isMe: true,
    ),
    ChatMessage(
      messageId: '11',
      senderId: '101',
      receiverId: '102',
      message: 'Perfect! Looking forward to it.',
      isRead: true,
      isMe: false,
    ),
    ChatMessage(
      messageId: '12',
      senderId: '102',
      receiverId: '101',
      message: 'Me too! Do you need a ride?',
      isRead: true,
      isMe: true,
    ),
    ChatMessage(
      messageId: '13',
      senderId: '101',
      receiverId: '102',
      message: 'Yes, that would be great, thanks!',
      isRead: true,
      isMe: false,
    ),
    ChatMessage(
      messageId: '14',
      senderId: '102',
      receiverId: '101',
      message: 'No problem! I’ll pick you up at 8 AM.',
      isRead: true,
      isMe: true,
    ),
    ChatMessage(
      messageId: '15',
      senderId: '101',
      receiverId: '102',
      message: 'Sounds good! See you then.',
      isRead: true,
      isMe: false,
    ),
    ChatMessage(
      messageId: '16',
      senderId: '102',
      receiverId: '101',
      message: 'See you!',
      isRead: true,
      isMe: true,
    ),
    ChatMessage(
      messageId: '17',
      senderId: '101',
      receiverId: '102',
      message: 'By the way, do I need to bring anything?',
      isRead: true,
      isMe: false,
    ),
    ChatMessage(
      messageId: '18',
      senderId: '102',
      receiverId: '101',
      message: 'Just some water and snacks should be fine.',
      isRead: true,
      isMe: true,
    ),
    ChatMessage(
      messageId: '19',
      senderId: '101',
      receiverId: '102',
      message: 'Got it! I’ll bring some sandwiches too.',
      isRead: true,
      isMe: false,
    ),
    ChatMessage(
      messageId: '20',
      senderId: '102',
      receiverId: '101',
      message: 'Awesome! We’re all set then!',
      isRead: true,
      isMe: true,
    ),
  ].obs;

  // Method to send a message
  void sendMessage(String message) {
    var newMessage = ChatMessage(
      messageId: DateTime.now().toString(),
      senderId: '102',
      receiverId: '101',
      message: message,
      isRead: false,
      isMe: true,
    );
    chatMessages.add(newMessage);
    scrollToBottom();
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.jumpTo(
          scrollController.position.maxScrollExtent,
        );
      }
    });
  }
}
