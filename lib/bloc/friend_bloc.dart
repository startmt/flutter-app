import 'dart:async';

import 'package:testapp/bloc/provider_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testapp/dto/userdata.dart';

class FriendBloc implements BlocBase {
  final Firestore firestore = Firestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  List<UserData> friendDatas = [];
  List<DocumentSnapshot> listFriend;
  StreamController<List<UserData>> streamControllerFriend =
      StreamController<List<UserData>>.broadcast();

  List<UserData> addedDatas = [];
  List<DocumentSnapshot> listAdded;
  StreamController<List<UserData>> streamControllerAdded =
      StreamController<List<UserData>>.broadcast();

  List<UserData> requestDatas = [];
  List<DocumentSnapshot> listRequest;
  StreamController<List<UserData>> streamControllerRequest =
      StreamController<List<UserData>>.broadcast();
  getListFriendData() {
    return friendDatas;
  }

  getListAddedData() {
    return addedDatas;
  }

  getListRequestData() {
    return requestDatas;
  }

  getFriend() async {
    getData('friends');
  }

  getAdded() async {
    getData('added');
  }

  getRequest() async {
    getData('request');
  }

  getData(String collection) async {
    FirebaseUser user = await auth.currentUser();
    firestore
        .collection('user')
        .document(user.uid)
        .collection(collection)
        .getDocuments()
        .then((data) {
      if (collection == 'friends') {
        listFriend = data.documents;
        listFriend.forEach((doc) => {
              doc.data['ref'].get().then((friend) => {
                    friendDatas.add(UserData.formNameEmail(
                        friend.data['name'], friend.data['email'])),
                    streamControllerFriend.sink.add(friendDatas),
                  })
            });
      } else if (collection == 'added') {
        listAdded = data.documents;
        listAdded.forEach((doc) => {
              doc.data['ref'].get().then((added) => {
                    addedDatas.add(UserData.formNameEmail(
                        added.data['name'], added.data['email'])),
                    streamControllerAdded.sink.add(addedDatas),
                  })
            });
      } else if (collection == 'request') {
        listRequest = data.documents;
        listRequest.forEach((doc) => {
              doc.data['ref'].get().then((request) => {
                    requestDatas.add(UserData.formNameEmail(
                        request.data['name'], request.data['email'])),
                    streamControllerRequest.sink.add(requestDatas),
                  })
            });
      }
    });
  }

  @override
  void dispose() {
    streamControllerFriend.close();
    streamControllerAdded.close();
    streamControllerRequest.close();
  }
}
