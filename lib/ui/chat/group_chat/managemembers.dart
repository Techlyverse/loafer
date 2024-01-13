import 'package:flutter/material.dart';

class ManageMembers extends StatelessWidget {
  const ManageMembers({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 237, 232, 232),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text("Chat"),
              ),
              Tab(
                child: Text("Files"),
              ),
              Tab(
                child: Text("Task"),
              ),
            ],
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xff8ecae6).withOpacity(0.5),
                ),
                child: const Text(
                  "T",
                  style: TextStyle(color: Color(0xff8ecae6)),
                ),
              ),
              // CircleAvatar(child: Text("data"),
              // ),

              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Techlyverse',
                      style: TextStyle(fontSize: 17),
                    ),
                    SizedBox(height: 3),
                    Text(
                      "9 Membrers",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),

        body: const TabBarView(
          children: [
            Center(child: Text("No Chat Yet")),

            Center(child: Text("No Files Yet")),

            Center(child: Text("No Task Yet")),
            // Icon(Icons.directions_car),
            // Icon(Icons.directions_transit),
            // Icon(Icons.directions_bike),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.check),
        ),
      ),
    );
  }
}
