import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testapp/bloc/friend_bloc.dart';
import 'package:testapp/bloc/provider_bloc.dart';
class FriendTemplate extends StatefulWidget {
  @override
  _FriendTemplateState createState() => _FriendTemplateState();
  
}

class _FriendTemplateState extends State<FriendTemplate> {
  int friendCount = 0;
  
  @override
  Widget build(BuildContext context) {
    FriendBloc friendBloc = BlocProvider.of<FriendBloc>(context);
    friendBloc.setFriend();
    return Container(
      child: ListView.builder(
        itemCount: friendCount,
        itemBuilder: (context, index){
          return new ListTile(
                    title: new Text(' '),
                    subtitle: new Text(' ')
                  );
        },
      )
      );
  }
}