import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loafer/core/model/user_model.dart';
import 'package:loafer/providers/user_provider.dart';

import '../../core/preferences/preferences.dart';
import '../chat/individual_chat/individual_chat_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.uid, this.userModel});
  final String uid;
  final UserModel? userModel;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late bool isCurrentUser;
  late UserModel userModel;

  Future<void> initUser() async {
    if (widget.userModel != null) {
      userModel = widget.userModel!;
    } else {
      userModel = await UserProvider().getUserModel(
        context: context,
        uid: widget.uid,
      );
    }
    isCurrentUser = widget.uid == FirebaseAuth.instance.currentUser?.uid;
    setState(() {});
  }

  bool light = true;
  final MaterialStateProperty<Icon?> thumbIcon = MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  void initState() {
    super.initState();
    initUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.settings_outlined))
            ],
          ),
          CircleAvatar(
            radius: 100,
            backgroundImage: CachedNetworkImageProvider(userModel.imageUrl),
          ),
          const SizedBox(height: 20),
          Text(
            userModel.name,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 5),
          Text(userModel.email),
          const SizedBox(height: 20),
          if (!isCurrentUser)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IndividualChatScreen(remoteUserId: userModel.uid, remoteUser: userModel,)));
              },
              child: const Text("Message"),
            ),
          if (isCurrentUser)
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await Preferences.clear();
              },
              child: const Text("Logout"),
            ),
        ],
      ),
    );
  }
}
