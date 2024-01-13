import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/helper/firebase_helper.dart';
import '../../core/model/room_model.dart';
import 'feed_tile.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key, required this.isGroupFeed});
  final bool isGroupFeed;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseHelper.rooms
            .where("isGroup", isEqualTo: isGroupFeed)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          } else if (snapshot.data != null && snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                final RoomModel feedModel = RoomModel.fromJson(snapshot.data!.docs[index].data() as Map<String, dynamic>);
                return FeedTile(roomModel: feedModel);
              },
            );
          } else {
            return const Center(child: Text(" No chat found"));
          }
        });
  }
}
