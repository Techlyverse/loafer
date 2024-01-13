import 'package:flutter/material.dart';
import 'managemembers.dart';

class GroupInfoScreen extends StatefulWidget {
  const GroupInfoScreen({super.key});

  @override
  State<GroupInfoScreen> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<GroupInfoScreen> {
  bool light = true;
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xff8ecae6)),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.edit))],
      ),
      body: Column(
        children: [
          const Text("Name"),
          ListTile(
            title: const Text("Manage Members"),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ManageMembers())),
            // trailing: Icon(Icons.abc),
            leading: const Icon(Icons.person_add_alt),
          ),
          const ListTile(
            title: Text("Manage Apps"),

            // trailing: Icon(Icons.abc),
            leading: Icon(Icons.keyboard),
          ),
          const ListTile(
            title: Text("Shared Media"),
            // trailing: Icon(Icons.abc),
            leading: Icon(Icons.photo_album),
          ),
          ListTile(
            title: const Text("History is on"),
            subtitle: const Text("Message sent now are saved"),
            leading: const Icon(Icons.punch_clock_sharp),
            // trailing: Icon(Icons.abc),
            trailing: Switch(
              // This bool value toggles the switch.
              value: light,
              thumbIcon: thumbIcon,
              // activeColor: Colors.red,
              onChanged: (bool value) {
                // This is called when the user toggles the switch.
                setState(() {
                  light = value;
                });
              },
            ),
          ),
          const ListTile(
            title: Text("Mark as unread"),
            // trailing: Icon(Icons.abc),
            leading: Icon(Icons.message),
          ),
          const ListTile(
            title: Text("Pin"),
            // trailing: Icon(Icons.pin),
            leading: Icon(Icons.pin),
          ),
          const ListTile(
            title: Text("Mute"),
            // trailing: Icon(Icons.abc),
            leading: Icon(Icons.mic),
          ),
          const ListTile(
            title: Text("Notification"),
            // trailing: Icon(Icons.abc),
            leading: Icon(Icons.notification_important_rounded),
          ),
          const ListTile(
            title: Text("Leave"),
            // trailing: Icon(Icons.abc),
            leading: Icon(Icons.logout),
          ),
          const ListTile(
            title: Text("Block and report"),
            // trailing: Icon(Icons.abc),
            leading: Icon(Icons.no_encryption),
          ),
        ],
      ),
    );
  }
}
