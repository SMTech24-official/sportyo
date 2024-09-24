class ChatMessage {
  final String messageId;
  final String senderId;
  final String receiverId;
  final String message;
  final bool isRead;
  final bool isMe;

  ChatMessage({
    required this.messageId,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.isRead,
    required this.isMe,
  });
}
