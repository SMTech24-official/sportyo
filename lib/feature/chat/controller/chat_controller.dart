// lib/controller/chats_controller.dart

import 'dart:convert';
import 'package:flutter/foundation.dart';
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

  // Indicates whether messages are loading
  var isLoading = false.obs;

  // Indicates if the other user is typing
  var isTyping = false.obs;

  // Indicates if the other user is active
  var isActive = false.obs;

  // Holds the receiverId if a room join is attempted before senderId is loaded
  String? pendingReceiverId;

  // Current receiverId
  String? currentReceiverId;

  @override
  void onInit() {
    super.onInit();
    webSocketService = WebSocketService();
    webSocketService.setOnMessageReceived(handleIncomingMessage);
    getSenderIdFromPreferences().then((_) {
      // Mark that senderId has been loaded
      isSenderIdLoaded.value = true;

      if (kDebugMode) {
        print("Sender ID successfully loaded: ${senderId.value}");
      }

      // Initialize WebSocket after retrieving senderId
      webSocketService.initSocket();

      // If there is a pending receiverId, join the room now
      if (pendingReceiverId != null) {
        webSocketService.joinRoom(senderId.value, pendingReceiverId!);

        connectToRoom(pendingReceiverId!);

        pendingReceiverId = null; // Clear after joining
      }
    });
  }

  // Retrieve the senderId from SharedPreferences
  Future<void> getSenderIdFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedSenderId = prefs.getString('userId');

    if (storedSenderId != null && storedSenderId.isNotEmpty) {
      senderId.value = storedSenderId;
    } else {
      if (kDebugMode) {
        print("Sender ID loaded from SharedPreferences: ${senderId.value}");
      } else {
        if (kDebugMode) {
          print("Sender ID is missing or not found in SharedPreferences.");
        }
      }
    }
  }

  // Join a room with receiverId
  void connectToWebSocketAndJoinRoom(String receiverId) {
    if (isSenderIdLoaded.value) {
      currentReceiverId = receiverId; // Set currentReceiverId
      connectToRoom(receiverId);
    } else {
      // If senderId is not yet loaded, store the receiverId to join later
      pendingReceiverId = receiverId;
      if (kDebugMode) {
        print(
            "Sender ID is not available yet. Will join the room once it is loaded.");
      }
    }
  }

  // Helper method to join a room and set loading state
  void connectToRoom(String receiverId) {
    isLoading.value = true; // Start loading
    webSocketService.joinRoom(senderId.value, receiverId);
    if (kDebugMode) {
      print("Joined room with receiverId: $receiverId");
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
        if (kDebugMode) {
          print("Conversation ID set to: ${conversationId.value}");
        }

        chatMessages.clear(); // Clear old messages

        for (var messageData in messages) {
          chatMessages.add(ChatMessage.fromJson(messageData, senderId.value));
        }

        isLoading.value = false; // Stop loading after messages are loaded

        scrollToBottom();
        break;

      case 'receiveMessage':
        final newMessageData = parsedData['message'];

        conversationId.value =
            parsedData['conversationId'] ?? conversationId.value;

        var newMessage = ChatMessage.fromJson(newMessageData, senderId.value);

        // Check if the message already exists to prevent duplication
        if (!chatMessages.any((msg) => msg.messageId == newMessage.messageId)) {
          chatMessages.add(newMessage);
          scrollToBottom();
        } else {
          if (kDebugMode) {
            print("Duplicate message detected: ${newMessage.messageId}");
          }
        }
        break;

      case 'typing':
        final username = parsedData['username'];
        if (kDebugMode) {
          print('$username is typing...');
        }
        isTyping.value = true; // Set typing to true

        // Reset typing status after 2 seconds of no typing event
        Future.delayed(const Duration(seconds: 2), () {
          isTyping.value = false;
        });
        break;

      case 'activeStatus':
        final userId = parsedData['userId'];
        final activeStatus = parsedData['isActive'];
        if (kDebugMode) {
          print("User $userId is active: $activeStatus");
        }
        if (userId == currentReceiverId) {
          isActive.value = activeStatus;
        }
        break;

      default:
        if (kDebugMode) {
          print('Unknown message type: ${parsedData['type']}');
        }
    }
  }

  //RxInt messageCount = 0.obs;
  // Send a new message
  void sendMessage(String message, String senderName) {
    if (conversationId.value.isEmpty) {
      if (kDebugMode) {
        print("No conversation ID found, join room first.");
      }
      return;
    }
    //messageCount.value++;
    webSocketService.sendMessage(
      conversationId.value,
      senderId.value,
      senderName,
      message,
    );
    // if (messageCount.value == 1) {
    //   final ChatsListController controller = Get.put(ChatsListController());
    //   controller.fetchChatUsers();
    // }
  }

  // Emit typing notification to WebSocket
  void emitTyping() {
    if (conversationId.value.isNotEmpty) {
      webSocketService.emitTyping(conversationId.value, 'YourUsername');
    }
  }

  // Disconnect WebSocket when leaving the screen
  void disconnectFromWebSocket() {
    webSocketService.disconnect();
  }

  // Scroll to the bottom of the chat instantly
  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(
          scrollController.position.maxScrollExtent,
        );
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

  // @override
  // void dispose() {
  //   super.dispose();
  //   final ChatsListController controller = Get.put(ChatsListController());
  //   controller.fetchChatUsers();
  // }
}
