import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testapp/bloc/friend_bloc.dart';
import 'package:testapp/bloc/provider_bloc.dart';
import 'package:testapp/chatroom_screen.dart';

class FriendTemplate extends StatefulWidget {
  @override
  _FriendTemplateState createState() => _FriendTemplateState();
}

class _FriendTemplateState extends State<FriendTemplate> {
  Firestore firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    FriendBloc friendBloc = BlocProvider.of<FriendBloc>(context);
    friendBloc.getFriend();
    return Container(
        child: StreamBuilder(
      stream: friendBloc.streamControllerFriend.stream,
      initialData: [],
      builder: (context, snapshot) {
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            return new ListTile(
                title: new Text(snapshot.data[index].name),
                subtitle: new Text(snapshot.data[index].email),
                onTap: () async {
                  FirebaseUser user = await FirebaseAuth.instance.currentUser();
                  QuerySnapshot friendQ = await firestore
                      .collection('user')
                      .where('email', isEqualTo: snapshot.data[index].email)
                      .getDocuments();
                  DocumentReference friendRef = firestore
                      .collection('user')
                      .document(friendQ.documents[0].documentID);
                  QuerySnapshot q = await firestore
                      .collection('user')
                      .document(user.uid)
                      .collection('friends')
                      .where('ref', isEqualTo: friendRef)
                      .getDocuments();
                  DocumentReference session = q.documents[0].data['session'];
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatRoomScreen(
                              session: session,
                              name: snapshot.data[index].name,
                              uid: user.uid)));
                });
          },
        );
      },
    ));
  }
}
