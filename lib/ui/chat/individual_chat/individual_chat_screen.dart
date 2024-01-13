import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loafer/core/helper/firebase_helper.dart';
import 'package:loafer/core/model/room_model.dart';
import 'package:loafer/core/preferences/preferences.dart';
import 'package:loafer/providers/user_provider.dart';
import '../../../core/model/member_model.dart';
import '../../../core/model/message_model.dart';
import '../../../core/model/user_model.dart';
import '../message_tile.dart';

class IndividualChatScreen extends StatefulWidget {
  const IndividualChatScreen(
      {super.key, required this.remoteUserId, this.remoteUser});
  final String remoteUserId;
  final UserModel? remoteUser;

  @override
  State<IndividualChatScreen> createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends State<IndividualChatScreen> {
  final TextEditingController msgController = TextEditingController();
  final UserModel? currentUser = Preferences.getUserModel();
  late UserModel remoteUser;
  late String roomId;
  late RoomModel roomModel;

  MessageModel? lastMessage;

  Future<void> _getUserModel() async {
    if (widget.remoteUser != null) {
      remoteUser = widget.remoteUser!;
    } else {
      remoteUser = await UserProvider().getUserModel(
        context: context,
        uid: widget.remoteUserId,
      );
    }
    setState(() {});
  }

  String _getRoomId() {
    final String remoteUserId = remoteUser.uid;
    final String currentUserId = currentUser!.uid;
    int res = remoteUserId.compareTo(currentUserId);
    return res > 0
        ? "${remoteUserId}_$currentUserId"
        : "${currentUserId}_$remoteUserId";
  }

  @override
  void initState() {
    super.initState();
    if (currentUser == null) logout(context);

    _getUserModel();
    roomId = _getRoomId();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(remoteUser.imageUrl),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    remoteUser.name,
                    style: const TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    remoteUser.isOnline ? "Online" : "Offline",
                    style: const TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.videocam_outlined,
            ),
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'Option 1',
                  child: Text('Option 1'),
                ),
                const PopupMenuItem(
                  value: 'Option 2',
                  child: Text('Option 2'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseHelper.messages.where("roomId", isEqualTo: roomId).snapshots(),
              builder: (context, snapshot) {
                lastMessage = MessageModel.fromJson(snapshot.data?.docs.last.data() as Map<String, dynamic>);
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8.0),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final MessageModel chatModel = MessageModel.fromJson(snapshot.data?.docs[index].data() as Map<String, dynamic>);
                      UserModel user = chatModel.senderId == currentUser!.uid
                          ? currentUser!
                          : remoteUser;
                      final MemberModel memberModel = MemberModel(userModel: user, isActive: user.isOnline,);
                      return MessageTile(
                        memberModel: memberModel,
                        chatModel: chatModel,
                      );
                    },
                  ),
                );
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: colorScheme.primary,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: msgController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.image_outlined,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    sendMessage();
                  },
                  icon: Icon(
                    Icons.send_outlined,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getLastMessageId(){
    final String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    if(lastMessage?.senderId == currentUser?.uid){
      return lastMessage!.messageId;
    }
    else{
      return timeStamp;
    }
  }

  Future<void> sendMessage() async {
    if (msgController.text.isEmpty) return;
    String lastMessageId = getLastMessageId();

    RoomModel room = roomModel.copyWith(
      lastMessage: msgController.text.trim(),
      lastMessageId: lastMessageId,
      lastMessageSendTime: DateTime.now().toIso8601String(),
      lastMessageSenderId: currentUser!.uid,
      lastMessageSenderName: currentUser!.name,
    );

    MessageModel messageModel = MessageModel(
      roomId: roomId,
      messageId: timeStamp,
      messages: [msgController.text.trim()],
      senderId: currentUser!.uid,
      sendTime: DateTime.now().toIso8601String(),
    );

    FirebaseHelper.messages.doc(timeStamp).set(messageModel.toJson());
    msgController.clear();
  }
}

/*
  Future<void> sendMessage() async {
    final String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    if (msgController.text.isNotEmpty) {
      MessageModel messageModel = MessageModel(
        roomId: roomId,
        messageId: timeStamp,
        messages: [msgController.text.trim()],
        senderId: currentUser!.uid,
        time: DateTime.now().toIso8601String(),
      );
      FirebaseHelper.messages.doc(timeStamp).set(messageModel.toJson());
      msgController.clear();
    }
  }
 */
