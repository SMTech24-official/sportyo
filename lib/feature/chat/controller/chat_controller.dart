// lib/controller/chats_controller.dart

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/chat_model.dart';
import '../service/socket_service.dart';

class ChatsController extends GetxController {
  var messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  var chatMessages = <ChatMessage>[].obs;
  var conversationId = ''.obs; // This holds the conversation ID.
  var senderId = ''.obs;
  late WebSocketService webSocketService;

  // Indicates whether senderId has been loaded
  var isSenderIdLoaded = false.obs;

  // Holds the receiverId if a room join is attempted before senderId is loaded
  String? pendingReceiverId;

  @override
  void onInit() {
    super.onInit();
    webSocketService = WebSocketService();
    webSocketService.setOnMessageReceived(handleIncomingMessage);
    getSenderIdFromPreferences().then((_) {
      // Mark that senderId has been loaded
      isSenderIdLoaded.value = true;
      log("Sender ID successfully loaded: ${senderId.value}");

      // Initialize WebSocket after retrieving senderId
      webSocketService.initSocket();

      // If there is a pending receiverId, join the room now
      if (pendingReceiverId != null) {
        webSocketService.joinRoom(senderId.value, pendingReceiverId!);
        log("Joined room with receiverId: $pendingReceiverId");
        pendingReceiverId = null; // Clear after joining
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  // Retrieve the senderId from SharedPreferences
  Future<void> getSenderIdFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedSenderId = prefs.getString('userId');

    if (storedSenderId != null && storedSenderId.isNotEmpty) {
      senderId.value = storedSenderId;
      log("Sender ID loaded from SharedPreferences: ${senderId.value}");
    } else {
      log("Sender ID is missing or not found in SharedPreferences.");
    }
  }

  // Join a room with receiverId
  void connectToWebSocketAndJoinRoom(String receiverId) {
    if (isSenderIdLoaded.value) {
      webSocketService.joinRoom(senderId.value, receiverId);
      print("Joined room with receiverId: $receiverId");
    } else {
      // If senderId is not yet loaded, store the receiverId to join later
      pendingReceiverId = receiverId;
      print(
          "Sender ID is not available yet. Will join the room once it is loaded.");
    }
  }

  // Handle incoming messages
  void handleIncomingMessage(String message) {
    final parsedData = jsonDecode(message);

    switch (parsedData['type']) {
      case 'loadMessages':
        final conversation = parsedData['conversation'];
        final messages = conversation['messages'];

        // Correctly set the conversationId using 'id'
        conversationId.value = conversation['id'];
        print("Conversation ID set to: ${conversationId.value}");

        chatMessages.clear(); // Clear old messages

        for (var messageData in messages) {
          chatMessages.add(ChatMessage.fromJson(messageData, senderId.value));
        }

        scrollToBottom();
        break;

      case 'receiveMessage':
        final newMessageData = parsedData['message'];

        // Ensure the conversationId is set if not already
        conversationId.value =
            parsedData['conversationId'] ?? conversationId.value;

        var newMessage = ChatMessage.fromJson(newMessageData, senderId.value);

        // Check if the message already exists to prevent duplication
        if (!chatMessages.any((msg) => msg.messageId == newMessage.messageId)) {
          chatMessages.add(newMessage);
          scrollToBottom();
        } else {
          print("Duplicate message detected: ${newMessage.messageId}");
        }
        break;

      case 'typing':
        print('${parsedData['username']} is typing...');
        break;

      default:
        print('Unknown message type: ${parsedData['type']}');
    }
  }

  // Send a new message
  void sendMessage(String message, String senderName) {
    if (conversationId.value.isEmpty) {
      print("No conversation ID found, join room first.");
      return;
    }

    webSocketService.sendMessage(
      conversationId.value,
      senderId.value,
      senderName,
      message,
    );

    // Removed local addition to prevent duplication
    // If instant feedback is desired without duplication, consider alternative approaches
  }

  // Emit typing notification to WebSocket
  void emitTyping() {
    if (conversationId.value.isNotEmpty) {
      webSocketService.emitTyping(conversationId.value,
          'YourUsername'); // Replace 'YourUsername' as needed
    }
  }

  // Disconnect WebSocket when leaving the screen
  void disconnectFromWebSocket() {
    webSocketService.disconnect();
  }

  // Scroll to the bottom of the chat when new messages are added
  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  // Dispose controllers
  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    disconnectFromWebSocket();
    super.onClose();
  }
}
