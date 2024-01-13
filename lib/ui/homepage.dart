import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loafer/core/model/user_model.dart';
import 'package:loafer/core/preferences/preferences.dart';
import 'package:loafer/ui/notification/notification_page.dart';
import 'package:loafer/ui/profile/profile_page.dart';
import 'package:loafer/ui/search/search_page.dart';
import 'search/all_users.dart';
import 'chat/feed_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  UserModel? userModel = Preferences.getUserModel();

  static const List<Widget> listScreen = [
    FeedScreen(isGroupFeed: false),
    FeedScreen(isGroupFeed: true),
  ];
  int currentScreen = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      key: scaffoldKey,

      appBar: AppBar(
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(
                    uid: userModel!.uid,
                    userModel: userModel,
                  ),
                ),
              );
            },
            padding: EdgeInsets.zero,
            icon: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(userModel!.imageUrl),
            ),
          ),
        ),

        title: Text(
          "Hi ${userModel!.name.split(" ").first}",
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SearchPage()));
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationPage()));
            },
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),

      body: listScreen[currentScreen],

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //logout();
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AllUsersScreen()));
        },
        label: const Text('New chat'),
        icon: const Icon(Icons.chat_bubble_outline),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreen,
        height: 70,
        onDestinationSelected: (int index) {
          setState(() {
            currentScreen = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.chat_bubble_outline),
            selectedIcon: Icon(Icons.chat_bubble),
            label: 'Chats',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_alt_outlined),
            selectedIcon: Icon(Icons.people_alt),
            label: 'Groups',
          ),
        ],
      ),

    );
  }
}
