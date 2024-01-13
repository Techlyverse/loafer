class MessageModel {
  const MessageModel({
    required this.roomId,
    required this.messageId,
    required this.senderId,
    required this.sendTime,
    required this.messageType,
    required this.messages,
  });

  final String roomId;
  final String messageId;
  final String senderId;
  final String sendTime;
  final String messageType;
  final List<String> messages;

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      roomId: json['roomId'],
      messageId: json['messageId'],
      senderId: json['senderId'],
      sendTime: json['sendTime'],
      messageType: json['messageType'],
      messages: List.from(json['messages']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "roomId": roomId,
      "messageId": messageId,
      "senderId": senderId,
      "sendTime": sendTime,
      "messageType": messageType,
      "messages": messages,
    };
  }

  MessageModel copyWith({
    String? roomId,
    String? messageId,
    String? senderId,
    String? sendTime,
    String? messageType,
    List<String>? messages,
  }) {
    return MessageModel(
      roomId: roomId ?? this.roomId,
      messageId: messageId ?? this.messageId,
      senderId: senderId ?? this.senderId,
      sendTime: sendTime ?? this.sendTime,
      messageType: messageType ?? this.messageType,
      messages: messages ?? this.messages,
    );
  }
}
