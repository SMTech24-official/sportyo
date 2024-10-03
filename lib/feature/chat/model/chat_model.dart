// lib/model/chat_model.dart

class ChatMessage {
  final String messageId;
  final String conversationId;
  final String senderId;
  final String senderName;
  final String content;
  final DateTime createdAt;
  final bool isMe;

  ChatMessage({
    required this.messageId,
    required this.conversationId,
    required this.senderId,
    required this.senderName,
    required this.content,
    required this.createdAt,
    required this.isMe,
  });

  factory ChatMessage.fromJson(
      Map<String, dynamic> json, String currentUserId) {
    return ChatMessage(
      messageId: json['id'],
      conversationId: json['conversationId'],
      senderId: json['senderId'],
      senderName: json['senderName'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      isMe: json['senderId'] == currentUserId,
    );
  }
}
