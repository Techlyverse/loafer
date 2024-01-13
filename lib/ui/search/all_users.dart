import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loafer/core/helper/firebase_helper.dart';
import 'package:loafer/core/model/user_model.dart';

import '../profile/profile_page.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Users"),
      ),
      body: StreamBuilder(
          stream: FirebaseHelper.users.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data != null && snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    UserModel userModel = UserModel.fromJson(
                        snapshot.data?.docs[index].data()
                            as Map<String, dynamic>);
                    return userModel.uid != uid
                        ? ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilePage(
                                    uid: userModel.uid,
                                    userModel: userModel,
                                  ),
                                ),
                              );
                            },
                            leading: CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                  userModel.imageUrl),
                            ),
                            title: Text(userModel.name),
                            subtitle: Text(
                              userModel.email,
                              style: const TextStyle(fontSize: 12),
                            ),
                          )
                        : const SizedBox();
                  });
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset("assets/img/cat.jpg")),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "No user found",
                    textAlign: TextAlign.center,
                  )
                ],
              );
            }
          }),
    );
  }
}
