// lib/service/websocket_service.dart

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocketService {
  WebSocketChannel? _channel;
  Function(String)? onMessageReceived;

  // Method to set the callback
  void setOnMessageReceived(Function(String) callback) {
    onMessageReceived = callback;
  }

  // Initialize WebSocket connection
  void initSocket() {
    _channel = WebSocketChannel.connect(
      Uri.parse('ws://192.168.11.50:3000'),
    );

    // Handle incoming messages
    _channel?.stream.listen(
      (message) {
        if (kDebugMode) {
          print('Received message: $message');
        }
        if (onMessageReceived != null) {
          onMessageReceived!(message);
        }
      },
      onError: (error) {
        if (kDebugMode) {
          print('WebSocket error: $error');
        }
      },
      onDone: () {
        if (kDebugMode) {
          print('WebSocket connection closed');
        }
      },
    );
  }

  // Join a room with user IDs
  void joinRoom(String user1Id, String user2Id) {
    final message = jsonEncode({
      'type': 'joinRoom',
      'user1Id': user1Id,
      'user2Id': user2Id,
    });
    _channel?.sink.add(message);
    if (kDebugMode) {
      print('Joined room with user1Id: $user1Id and user2Id: $user2Id');
    }
  }

  // Send a chat message
  void sendMessage(
      String chatroomId, String senderId, String senderName, String content) {
    final message = jsonEncode({
      'type': 'sendMessage',
      'chatroomId': chatroomId,
      'senderId': senderId,
      'senderName': senderName,
      'content': content,
    });
    _channel?.sink.add(message);
    if (kDebugMode) {
      print('Message sent: "$content" from sender: $senderName');
    }
  }

  // Emit typing notification
  void emitTyping(String typingRoomId, String username) {
    final message = jsonEncode({
      'type': 'typing',
      'typingRoomId': typingRoomId,
      'username': username,
    });
    _channel?.sink.add(message);
    if (kDebugMode) {
      print('Typing notification sent for username: $username');
    }
  }

  // Disconnect WebSocket
  void disconnect() {
    _channel?.sink.close(status.goingAway);
    if (kDebugMode) {
      print('WebSocket connection closed');
    }
  }
}
