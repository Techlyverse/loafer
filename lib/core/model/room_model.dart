class RoomModel {
  const RoomModel({
    required this.isGroupChat,
    required this.roomId,
    required this.roomName,
    required this.roomAvatar,
    required this.roomCreationTime,

    this.lastMessage,
    this.lastMessageId,
    this.lastMessageType,
    this.lastMessageSendTime,

    this.lastMessageSenderId,
    this.lastMessageSenderName,
  });

  // identify is group chat or individual chat
  final bool isGroupChat;

  // room details
  final String roomId;
  final String roomName;
  final String roomAvatar;
  final String roomCreationTime;

  // last message details
  final String? lastMessage;
  final String? lastMessageId;
  final String? lastMessageType;
  final String? lastMessageSendTime;

  // last message sender details
  final String? lastMessageSenderId;
  final String? lastMessageSenderName;

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      isGroupChat: json['isGroupChat'],
      roomId: json['roomId'],
      roomName: json['roomName'],
      roomAvatar: json['roomAvatar'],
      roomCreationTime: json['roomCreationTime'],
      lastMessage: json['lastMessage'],
      lastMessageId: json['lastMessageId'],
      lastMessageType: json['lastMessageType'],
      lastMessageSendTime: json['lastMessageSendTime'],
      lastMessageSenderId: json['lastMessageSenderId'],
      lastMessageSenderName: json['lastMessageSenderName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "isGroupChat": isGroupChat,
      "roomId": roomId,
      "roomName": roomName,
      "roomAvatar": roomAvatar,
      "roomCreationTime": roomCreationTime,
      "lastMessage": lastMessage,
      "lastMessageId": lastMessageId,
      "lastMessageType":lastMessageType,
      "lastMessageSendTime": lastMessageSendTime,
      "lastMessageSenderId": lastMessageSenderId,
      "lastMessageSenderName": lastMessageSenderName,
    };
  }

  RoomModel copyWith({
    bool? isGroupChat,
    String? roomId,
    String? roomName,
    String? roomAvatar,
    String? roomCreationTime,
    String? lastMessage,
    String? lastMessageId,
    String? lastMessageType,
    String? lastMessageSendTime,
    String? lastMessageSenderId,
    String? lastMessageSenderName,
  }) {
    return RoomModel(
      isGroupChat: isGroupChat ?? this.isGroupChat,
      roomId: roomId ?? this.roomId,
      roomName: roomName ?? this.roomName,
      roomAvatar: roomAvatar ?? this.roomAvatar,
      roomCreationTime: roomCreationTime ?? this.roomCreationTime,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageId: lastMessageId ?? this.lastMessageId,
      lastMessageType: lastMessageType ?? this.lastMessageType,
      lastMessageSendTime: lastMessageSendTime ?? this.lastMessageSendTime,
      lastMessageSenderId: lastMessageSenderId ?? this.lastMessageSenderId,
      lastMessageSenderName: lastMessageSenderName ?? this.lastMessageSenderName,
    );
  }
}
