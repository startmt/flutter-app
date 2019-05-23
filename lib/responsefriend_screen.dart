import 'package:flutter/material.dart';

import 'bloc/friend_bloc.dart';
import 'bloc/provider_bloc.dart';
import 'component/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dto/userdata.dart';
class ResponseFriend extends StatefulWidget {
  ResponseFriend({Key key}) : super(key: key);
  _ResponseFriendState createState() => _ResponseFriendState();
}

class _ResponseFriendState extends State<ResponseFriend> {
  @override
  Widget build(BuildContext context) {
    final FriendBloc friendBloc = BlocProvider.of<FriendBloc>(context);
    final Firestore firestore = Firestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
    friendBloc.getRequest();

    List requestList = friendBloc.getListRequestData();

    _manageRequest(String email, String status) async{
      FirebaseUser user = await auth.currentUser();
      final DocumentReference userRef = firestore
          .collection('user')
          .document(user.uid);

       QuerySnapshot friendQ = await firestore
           .collection('user')
           .where('email', isEqualTo: email)
           .getDocuments();

       final DocumentReference friendRef = friendQ
           .documents[0]
           .reference;

       userRef
           .collection('request')
           .document(friendRef.documentID)
           .delete();

       friendRef
           .collection('added')
           .document(user.uid)
           .delete();
       if(status == 'accept'){
         DocumentReference session = await firestore.collection('chat').add(({}));
         userRef
             .collection('friends')
             .document(friendRef.documentID)
             .setData(({
           'ref': friendRef,
           'session': session
         }));

         friendRef
             .collection('friends')
             .document(user.uid)
             .setData(({
           'ref': userRef,
           'session': session
         }));
       }
    }
    listrequest(UserData data) {
      String name = data.name;
      String email = data.email;
      return ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: 30.0, vertical: 10.0),
          leading: Container(
            child: Icon(Icons.people, color: Colors.black),
          ),
          title: Row(
            children: <Widget>[
              Text(
                name,
                style: Theme.of(context).textTheme.body1,
              ),
              Text(
                ' ('+ email +')',
                style: Theme.of(context).textTheme.body2,
              )
            ],
          ),
          subtitle: Row(
            children: <Widget>[

              RaisedButton(child: Text("Accept"),color: Colors.green,onPressed:()=> _manageRequest(email, 'accept'),),
              Padding(padding: EdgeInsets.all(4),),
              RaisedButton(child: Text('cancel'),color: Colors.grey,onPressed: ()=> _manageRequest(email, 'cancel')),
            ],
          ),
      );
    }
        return Scaffold(
            appBar: PreferredSize(
                child: AppbarImplement.getAppBar("Response Friend", context),
                preferredSize: const Size(50, 45)),
            body: StreamBuilder(
                stream: friendBloc.streamControllerRequest.stream,
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: requestList.length,
                    itemBuilder: (context, index) {
                      return
                          Container(
                              child: listrequest(snapshot.data[index],)
                      );
                    },
                  );
                }
            )
        );

  }
  }
