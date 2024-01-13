import 'package:flutter/material.dart';
import '../../core/model/room_model.dart';
import '../../widgets/status_bubble.dart';
import 'group_chat/group_chat_screen.dart';
import 'individual_chat/individual_chat_screen.dart';

class FeedTile extends StatelessWidget {
  const FeedTile({super.key, required this.roomModel});
  final RoomModel roomModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 40,
        width: 40,
        child: Stack(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(roomModel.roomAvatar),
            ),
            const Align(
              alignment: Alignment.bottomRight,
              child: StatusBubble(isOnline: false),
            )
          ],
        ),
      ),

      title: Text(
        roomModel.roomName,
        style: const TextStyle(fontSize: 15),
      ),
      subtitle: Text(
        roomModel.lastMessageSendTime ??  "",
        style: const TextStyle(fontSize: 13),
      ),
      trailing: Text(roomModel.roomCreationTime),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>

                  roomModel.isGroupChat ? GroupChatScreen(roomId: roomModel.roomId, roomModel: roomModel,): IndividualChatScreen(remoteUserId: roomModel.lastMessageSenderId!,),

            ));
      },
    );
  }
}
