import 'package:flutter/material.dart';
import '../chat_screen.dart';
import '../friend_screen.dart';
import '../profile_screen.dart';
class MyTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Theme(
        data: ThemeData(
          brightness: Brightness.light,
          ),
        child: Scaffold(
        bottomNavigationBar: TabBar(
            tabs:[
              Tab(icon: Icon(Icons.people), text: 'Friend'), 
              Tab(icon: Icon(Icons.chat), text: 'Chat'),
              Tab(icon: Icon(Icons.supervised_user_circle), text: 'Profile')
            ],
            unselectedLabelColor: Colors.black26,
            labelColor: Colors.orange,
            indicatorColor: Colors.transparent,
            ),
            body: TabBarView(
              children: [
                Center(child: FriendScreen()),
                Center(child: ChatScreen()),
                Center(child: ProfileScreen())
              ])
        ),
      )
      );
  }
}
