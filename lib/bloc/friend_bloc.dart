
import 'dart:async';

import 'package:testapp/bloc/provider_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testapp/dto/userdata.dart';

class FriendBloc implements BlocBase{
  final Firestore firestore = Firestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  List<DocumentSnapshot> listDocs;
  List<UserData> userDatas = [];
  StreamController <List<UserData>> streamControllerFriend =  StreamController <List<UserData>>.broadcast();

  setFriend(){
    firestore.collection('user').document('oYKrhquUNlQfKhYr2GwE44RwyoS2').collection('added').getDocuments().then((data){
      listDocs = data.documents;
      listDocs.forEach((doc)=>{
        doc.data['ref'].get().then((friend)=>{
          userDatas.add(UserData.formNameEmail(friend.data['name'], friend.data['email'])),
          print(userDatas),
          streamControllerFriend.sink.add(userDatas),
        })
      });
  });
  }

  @override
  void dispose() {
   streamControllerFriend.close(); 
  }
}
