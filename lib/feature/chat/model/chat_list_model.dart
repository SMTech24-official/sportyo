class ChatUser {
  String id;
  String firstName;
  String lastName;
  String userProfileImage;
  String senderId;
  String lastMessageContent;
  bool isOther;

  ChatUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userProfileImage,
    required this.senderId,
    required this.lastMessageContent,
    required this.isOther,
  });

  factory ChatUser.fromJson(Map<String, dynamic> json) {
    var chatUser = json['chatUser'];
    var lastMessage = json['lastMessage'];
    bool isOther =
        (lastMessage != null) && (chatUser['id'] != lastMessage['senderId']);

    return ChatUser(
      id: chatUser['id'],
      firstName: chatUser['firstName'] ?? '',
      lastName: chatUser['lastName'] ?? '',
      userProfileImage: chatUser['userProfileImage'] ?? '',
      senderId: lastMessage != null ? lastMessage['senderId'] : '',
      lastMessageContent: lastMessage != null ? lastMessage['content'] : '',
      isOther: isOther,
    );
  }
}
