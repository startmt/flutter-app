import 'package:flutter/material.dart';
import '../chat_screen.dart';
import '../friend_screen.dart';
import '../profile_screen.dart';
class MyTabBar extends StatefulWidget {
  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  int _selectedIndex = 0;
static  List<Widget> _widgetOptions = <Widget>[
  FriendScreen(),
  ChatScreen(),
  ProfileScreen()
];

void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: _widgetOptions.elementAt(_selectedIndex),
    ),
    bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          title: Text('Friend'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          title: Text('Chat'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text('Setting'),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.orange,
      onTap: _onItemTapped,
    ),
  );
}
  }
// class MyTabBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Theme(
//         data: ThemeData(
//           brightness: Brightness.light,
//           ),
//         child: Scaffold(
//         bottomNavigationBar: TabBar(
//             tabs:[
//               Tab(icon: Icon(Icons.people), text: 'Friend'), 
//               Tab(icon: Icon(Icons.chat), text: 'Chat'),
//               Tab(icon: Icon(Icons.supervised_user_circle), text: 'Profile')
//             ],
//             unselectedLabelColor: Colors.black26,
//             labelColor: Colors.orange,
//             indicatorColor: Colors.transparent,
//             ),
//             body: TabBarView(
//               children: [
//                 Center(child: FriendScreen()),
//                 Center(child: ChatScreen()),
//                 Center(child: ProfileScreen())
//               ])
//         ),
//       )
//       );
//   }
// }
