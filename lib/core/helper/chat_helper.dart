import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:loafer/core/model/room_model.dart';

import '../model/message_model.dart';
import '../model/user_model.dart';
import '../preferences/preferences.dart';
import 'firebase_helper.dart';

class ChatHelper {
  void sendMessage(
    BuildContext context,
    MessageModel? previousMessage,
    RoomModel roomModel,
  ) {
    final UserModel? currentUser = Preferences.getUserModel();
    if (currentUser == null) return;

    late bool createNewSnapshot;
    late bool isPreviousMsgSendByMe;
    if (previousMessage != null) {
      // check is previous message send by current user
      isPreviousMsgSendByMe = previousMessage.senderId == currentUser.uid;

      // get id for current message
      String messageId = isPreviousMsgSendByMe
          ? previousMessage.messageId
          : DateTime.now().millisecondsSinceEpoch.toString();
      var messages = previousMessage.messages;
      messages.add(roomModel.lastMessage!);

      // create message model
      MessageModel messageModel = isPreviousMsgSendByMe
          ? previousMessage.copyWith(
              messages: messages,
              messageType: roomModel.lastMessageType,
            )
          : MessageModel(
              roomId: roomModel.roomId,
              messageId: messageId,
              senderId: currentUser.uid,
              sendTime: DateTime.now().toIso8601String(),
              messageType: roomModel.lastMessageType ?? "",
              messages: messages,
            );

      FirebaseHelper.roomDoc(roomModel.roomId).update(roomModel.toJson());
      FirebaseHelper.messageDoc(messageId).update(messageModel.toJson());
    }
    if (isPreviousMsgSendByMe) {
    } else {}

    FirebaseHelper.messages.doc(messageId).set(messageModel.toJson());
  }
}
