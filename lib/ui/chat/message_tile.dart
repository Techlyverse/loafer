import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loafer/core/helper/ui_helper.dart';
import 'package:loafer/core/model/message_model.dart';
import 'package:loafer/core/model/member_model.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({
    super.key,
    required this.memberModel,
    required this.chatModel,
  });

  final MemberModel memberModel;
  final MessageModel chatModel;

  @override
  Widget build(BuildContext context) {
    final bool isMe = chatModel.senderId == FirebaseAuth.instance.currentUser?.uid;
    final chatColor = UiHelper.chatColor(context, memberModel.userModel);

    return Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        isMe
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  chatModel.messageId,
                  //' ${timestamp.hour}:${timestamp.minute} | ${timestamp.day}/${timestamp.month}/${timestamp.year}',
                  style: const TextStyle(fontSize: 10.0, color: Colors.grey),
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  memberModel.userModel
                      .name, //${timestamp.hour}:${timestamp.minute} | ${timestamp.day}/${timestamp.month}/${timestamp.year}
                  style: const TextStyle(fontSize: 10.0, color: Colors.grey),
                ),
              ),

        ListView.builder(
            shrinkWrap: true,
            itemCount: chatModel.messages.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Container(
                    margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: chatColor.$1,
                      borderRadius: isMe
                          ? BorderRadius.circular(25).copyWith(bottomRight: Radius.zero)
                          : BorderRadius.circular(25).copyWith(bottomLeft: Radius.zero),
                    ),
                    child: Text(
                      chatModel.messages[index],
                      style: TextStyle(color: chatColor.$2),
                    ),
                  ),
                ],
              );
            })
      ],
    );
  }
}
