// lib/service/websocket_service.dart

import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class WebSocketService {
  WebSocketChannel? _channel;
  Function(String)? onMessageReceived; // Callback for incoming messages

  // Method to set the callback
  void setOnMessageReceived(Function(String) callback) {
    onMessageReceived = callback;
  }

  // Initialize WebSocket connection
  void initSocket() {
    _channel = WebSocketChannel.connect(
      Uri.parse(
          'ws://192.168.11.50:3000'), // Replace with your server's WebSocket URL
    );

    // Handle incoming messages
    _channel?.stream.listen(
      (message) {
        print('Received message: $message');
        if (onMessageReceived != null) {
          onMessageReceived!(message); // Forward the message to the controller
        }
      },
      onError: (error) {
        print('WebSocket error: $error');
        // Optionally implement reconnection logic here
      },
      onDone: () {
        print('WebSocket connection closed');
        // Optionally implement reconnection logic here
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
    print('Joined room with user1Id: $user1Id and user2Id: $user2Id');
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
    print('Message sent: "$content" from sender: $senderName');
  }

  // Emit typing notification
  void emitTyping(String typingRoomId, String username) {
    final message = jsonEncode({
      'type': 'typing',
      'typingRoomId': typingRoomId,
      'username': username,
    });
    _channel?.sink.add(message);
    print('Typing notification sent for username: $username');
  }

  // Disconnect WebSocket
  void disconnect() {
    _channel?.sink.close(status.goingAway);
    print('WebSocket connection closed');
  }
}
