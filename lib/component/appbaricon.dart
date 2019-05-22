import 'package:flutter/material.dart';
import 'package:testapp/addfriend.dart';
import 'package:testapp/bloc/friend_bloc.dart';
import 'package:testapp/bloc/provider_bloc.dart';

class AppbarIcon {
  static getAppBarIcon(String title, BuildContext context) {
    if (title == 'Friend') {
      return <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                        bloc: FriendBloc(), child: AddFriendScreen())));
          },
        ),
        IconButton(
          icon: Icon(Icons.people),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                        bloc: FriendBloc(), child: AddFriendScreen())));
          },
        )
      ];
    } else if (title == 'Chat') {
      return <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddFriendScreen()));
          },
        )
      ];
    } else if (title == 'Setting') {
      return <Widget>[
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddFriendScreen()));
          },
        )
      ];
    } else {
      return <Widget>[];
    }
  }
}
