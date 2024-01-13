// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:loafer/core/helper/firebase_helper.dart';
// import 'package:loafer/core/model/member_model.dart';
// import 'package:loafer/core/model/message_model.dart';
// import '../../core/model/room_model.dart';
// import '../../core/model/user_model.dart';
// import 'message_tile.dart';
//
// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key, this.roomModel, required this.roomId});
//   final RoomModel? roomModel;
//   final String roomId;
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   late final RoomModel roomModel;
//
//   //Using a Map for members for faster access by uid
//   Map<String, MemberModel> members = {};
//
//   Future<void> _getMembers() async {
//     FirebaseHelper.members
//         .where("roomId", isEqualTo: widget.roomId)
//         .snapshots()
//         .listen((event) async {
//       for (var change in event.docChanges) {
//         switch (change.type) {
//           case DocumentChangeType.added:
//             _addChange(change);
//
//             break;
//           case DocumentChangeType.modified:
//             _updateChange(change);
//
//             break;
//           case DocumentChangeType.removed:
//             _removeChange(change);
//
//             break;
//         }
//       }
//     });
//   }
//
//   Future<void> _addChange(DocumentChange change) async {
//     final String memberId = change.doc['uid'];
//     final bool isActive = change.doc['isActive'];
//
//     // listening change in user snapshot
//     FirebaseHelper.userDoc(memberId).snapshots().listen((userSnapshot) {
//       final UserModel userModel =
//           UserModel.fromJson(userSnapshot.data() as Map<String, dynamic>);
//       final MemberModel memberModel = MemberModel(
//         userModel: userModel,
//         isActive: isActive,
//       );
//
//       setState(() {
//         members[memberId] = memberModel;
//       });
//     });
//   }
//
//   void _updateChange(DocumentChange member) {
//     final String memberId = member.doc['uid'];
//     MemberModel memberModel = members[memberId]!.copyWith(isActive: member.doc['isActive']);
//     members[memberId] = memberModel;
//     setState(() {});
//   }
//
//   void _removeChange(DocumentChange member) {
//     final String memberId = member.doc['uid'];
//     members.removeWhere((key, value) => key == memberId);
//     setState(() {});
//   }
//
//   Future<void> getRoomInfo() async {
//     if (widget.roomModel != null) {
//       setState(() {
//         roomModel = widget.roomModel!;
//       });
//     } else {
//       final DocumentSnapshot snapshot =
//           await FirebaseHelper.roomDoc(widget.roomId).get();
//       roomModel = RoomModel.fromJson(snapshot.data()! as Map<String, dynamic>);
//       setState(() {});
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getRoomInfo();
//     _getMembers();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//
//     return Scaffold(
//       appBar: AppBar(
//         titleSpacing: 0,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             CircleAvatar(
//               backgroundImage: CachedNetworkImageProvider(roomModel.imageUrl),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     roomModel.roomTitle,
//                     style: const TextStyle(fontSize: 17),
//                   ),
//                   const SizedBox(height: 3),
//                   Text(
//                     roomModel.time,
//                     style: const TextStyle(fontSize: 12),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.call_outlined),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(
//               Icons.videocam_outlined,
//             ),
//           ),
//           PopupMenuButton(
//             icon: const Icon(Icons.more_vert),
//             itemBuilder: (BuildContext context) {
//               return [
//                 const PopupMenuItem(
//                   value: 'Option 1',
//                   child: Text('Option 1'),
//                 ),
//                 const PopupMenuItem(
//                   value: 'Option 2',
//                   child: Text('Option 2'),
//                 ),
//               ];
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           StreamBuilder<QuerySnapshot>(
//               stream: FirebaseHelper.messages
//                   .where("roomId", isEqualTo: widget.roomId)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 return Expanded(
//                   child: ListView.builder(
//                     padding: const EdgeInsets.all(8.0),
//                     itemCount: snapshot.data?.docs.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       final MessageModel chatModel = MessageModel.fromJson(
//                           snapshot.data?.docs[index].data()
//                               as Map<String, dynamic>);
//                       return MessageTile(
//                         memberModel: members[chatModel.senderId]!,
//                         chatModel: chatModel,
//                       );
//                     },
//                   ),
//                 );
//               }),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 IconButton(
//                   onPressed: () {},
//                   icon: Icon(
//                     Icons.add_circle_outline,
//                     color: colorScheme.primary,
//                   ),
//                 ),
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Type a message...',
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 20,
//                         vertical: 8,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       suffixIcon: IconButton(
//                         onPressed: () {},
//                         icon: Icon(
//                           Icons.image_outlined,
//                           color: colorScheme.primary,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {},
//                   icon: Icon(
//                     Icons.send_outlined,
//                     color: colorScheme.primary,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
