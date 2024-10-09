// lib/controller/chats_controller.dart

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/service_class/network_caller/utility/usrls.dart';
import '../model/chat_model.dart';
import '../service/socket_service.dart';
import 'package:http/http.dart' as http;

class ChatsController extends GetxController {
  var messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  var chatMessages = <ChatMessage>[].obs;
  var conversationId = ''.obs;
  var senderId = ''.obs;
  var reciverUid = ''.obs;
  late WebSocketService webSocketService;

  var isSenderIdLoaded = false.obs;

  var isLoading = false.obs;

  var isTyping = false.obs;

  var isActive = false.obs;

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
      pendingReceiverId = receiverId;
      if (kDebugMode) {
        print(
            "Sender ID is not available yet. Will join the room once it is loaded.");
      }
    }
  }

  // Helper method to join a room and set loading state
  void connectToRoom(String receiverId) {
    isLoading.value = true;
    reciverUid.value = receiverId;
    log(reciverUid.toString());
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

  Future<void> reportUsers() async {
    try {
      EasyLoading.show(status: "Please wait");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      final url = Uri.parse('${Urls.baseUrl}/report');
      Map<String, dynamic> requestData = {
        "reportedUserId": reciverUid.value.toString()
      };
      final response = await http.post(
        url,
        headers: {
          'Authorization': token.toString(),
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );
      if (kDebugMode) {
        print(response.body);
      }
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        if (jsonData['success'] == true) {
          EasyLoading.showSuccess(jsonData['message']);
          Get.back();
        } else {
          EasyLoading.showError(jsonData['message']);
        }
      } else {
        EasyLoading.showError('Failed to load profile data');
      }
    } catch (e) {
      EasyLoading.showError('Failed to update user profile');
    } finally {
      EasyLoading.dismiss();
    }
  }

  Future<void> deleteConversation() async {
    try {
      EasyLoading.show(status: "Deleting conversation...");

      // Retrieve token from shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // ignore: unused_local_variable
      var token = prefs.getString("token");
      log(conversationId.value.toString());
      // Define the API URL for deleting a conversation
      final url = Uri.parse(
          '${Urls.baseUrl}/chat/conversation/${conversationId.value.toString()}');

      // Send the HTTP DELETE request
      final response = await http.delete(
        url,
        // headers: {
        //   'Authorization': token.toString(),
        //   'Content-Type': 'application/json',
        // },
      );
      log(response.body);
      // Handle the response
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['success'] == true) {
          EasyLoading.showSuccess('Conversation deleted successfully');
          Get.back();
        } else {
          EasyLoading.showError('Failed to delete conversation');
        }
      } else {
        EasyLoading.showError('Failed to delete conversation');
      }
    } catch (e) {
      EasyLoading.showError('An error occurred while deleting conversation');
    } finally {
      EasyLoading.dismiss();
    }
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
