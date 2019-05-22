import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'component/appbar.dart';

class ChatRoomScreen extends StatefulWidget {
  final DocumentReference session;
  final String name;
  ChatRoomScreen({Key key, @required this.session, @required this.name})
      : super(key: key);
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final Firestore firestore = Firestore.instance;
  List chatList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: AppbarImplement.getAppBar(this.widget.name, context),
            preferredSize: const Size(50, 45)),
        body: ListView(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: this.widget.session.collection('message').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  return (Container());
                }),

          ],
        ));
  }
}
