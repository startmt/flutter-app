    
import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test App',
      theme: ThemeData(
        primaryColor: Colors.white
        ),
        home: MyTabBar(),
        );
  }
}
class MyTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Theme(
        data: ThemeData(
          brightness: Brightness.dark
          ),
        child: Scaffold(
        bottomNavigationBar: TabBar(
            tabs:[
              Tab(icon: Icon(Icons.home), text: 'Home'), 
              Tab(icon: Icon(Icons.search), text: 'Search'),
              Tab(icon: Icon(Icons.supervised_user_circle), text: 'Profile')
            ],
            unselectedLabelColor: Color(0xff999999),
            labelColor: Colors.white,
            indicatorColor: Colors.transparent
            ),
            body: TabBarView(
              children: [
                Center( child: Text('Page 1')),
                Center( child: Text('Page 2')),
                Center( child: Text('Page 3'),)
              ],)
        ),
      )
      );
  }
}