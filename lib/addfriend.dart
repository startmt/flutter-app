import 'package:flutter/material.dart';
import 'package:testapp/dto/userdata.dart';
import 'bloc/provider_bloc.dart';
import 'component/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'bloc/friend_bloc.dart';

class AddFriendScreen extends StatefulWidget {
  @override
  _AddFriendScreenState createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final Firestore firestore = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  final searchController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  bool _addStatus = false;
  bool _responseStatus = false;
  String _userStatus = '';
  UserData resultData = UserData();
  @override
  Widget build(BuildContext context) {
    FriendBloc friendBloc = BlocProvider.of<FriendBloc>(context);
    friendBloc.getFriend();
    friendBloc.getAdded();
    friendBloc.getRequest();

    void checkFriend() async {
      List friendData = await friendBloc.getListFriendData();
      List addedData = await friendBloc.getListAddedData();
      List requestData = await friendBloc.getListRequestData();
      FirebaseUser user = await auth.currentUser();
      for (UserData friend in friendData) {
        if (friend.email == resultData.email) {
          print(friend.email);
          setState(() {
            _addStatus = false;
            _userStatus = "You been friend";
          });
          return null;
        }
      }
      for (UserData added in addedData) {
        if (added.email == resultData.email) {
          print(added.email);
          setState(() {
            _addStatus = false;
            _responseStatus = false;
            _userStatus = "You have sent request";
          });
          return null;
        }
      }
      for (UserData request in requestData) {
        if (request.email == resultData.email) {
          print(request.email);
          setState(() {
            _addStatus = false;
            _responseStatus = true;
            _userStatus = '';
          });
          return null;
        }
      }
      if (resultData.email == user.email) {
        setState(() {
          _responseStatus = false;
          _addStatus = false;
          _userStatus = "You can't add yourself";
        });
        return null;
      } else {
        print('Ok');
        setState(() {
          _responseStatus = false;
          _addStatus = true;
          _userStatus = "";
        });
      }
    }

    searchUser() {
      String _searchTxt = searchController.text;
      if (this._formKey.currentState.validate()) {
        firestore
            .collection('user')
            .where('email', isEqualTo: _searchTxt)
            .getDocuments()
            .then((val) => {
                  resultData.setUserData(val.documents[0].data['name'],
                      val.documents[0].data['email']),
                  checkFriend()
                })
            .catchError((err) => {
                  print(err),
                  setState(() {
                    _addStatus = false;
                    resultData.setUserData("", "");
                    _userStatus = 'Not found';
                  }),
                });
      }
    }

    Future<QuerySnapshot> getFriendref() async {
      String _searchTxt = searchController.text;
      return firestore
          .collection('user')
          .where('email', isEqualTo: _searchTxt)
          .getDocuments();
    }

    addFriend() async {
      FirebaseUser user = await auth.currentUser();
      QuerySnapshot ref = await getFriendref();
      DocumentReference docref =
          firestore.collection('user').document(ref.documents[0].documentID);
      DocumentReference userRef =
          firestore.collection('user').document(user.uid);

      firestore
          .collection('user')
          .document(user.uid)
          .collection('added')
          .document(docref.documentID)
          .setData(({'ref': docref}));
      docref
          .collection('request')
          .document(user.uid)
          .setData(({'ref': userRef}));
      print("Success");
      setState(() {
        _responseStatus = false;
        _addStatus = false;
        _userStatus = "You request this account";
      });
    }

    void responseFriend() async {
      FirebaseUser user = await auth.currentUser();
      QuerySnapshot ref = await getFriendref();
      DocumentReference docref =
          firestore.collection('user').document(ref.documents[0].documentID);
      DocumentReference userRef =
          firestore.collection('user').document(user.uid);

      DocumentReference session = await firestore.collection('chat').add(({}));
      firestore
          .collection('user')
          .document(user.uid)
          .collection('request')
          .document(docref.documentID)
          .delete();

      docref.collection('added').document(user.uid).delete();

      firestore
          .collection('user')
          .document(user.uid)
          .collection('friends')
          .document(docref.documentID)
          .setData(({'ref': docref, 'session': session}));

      docref
          .collection('friends')
          .document(user.uid)
          .setData(({'ref': userRef, 'session': session}));
      setState(() {
        _responseStatus = false;
        _addStatus = false;
        _userStatus = "You pair are friend";
      });
    }

    final responseBtn = RaisedButton(
        onPressed: () => responseFriend(),
        color: Colors.green,
        child: Text("Accept Friend"));
    final search = TextFormField(
      controller: searchController,
      keyboardType: TextInputType.emailAddress,
      validator: (val) {
        if (val.isEmpty) return "please fill in email";
        if (RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ==
            false) return "please enter correct email format";
      },
      decoration: InputDecoration(
        hintText: 'Please enter your email friend',
        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        suffixIcon: Icon(Icons.search),
      ),
    );

    final searchBtn =
        RaisedButton(onPressed: searchUser, child: Text("Search"));

    final resultText = Container(child: Text(resultData.name));
    final resultStatusText = Container(child: Text(_userStatus, style: Theme.of(context).textTheme.caption,));
    final addBtn = RaisedButton(
        onPressed: _addStatus ? () => addFriend() : null,
        color: Colors.green,
        child: Text("Add"));

    return Scaffold(
        appBar: PreferredSize(
            child: AppbarImplement.getAppBar("Add friend", context),
            preferredSize: const Size(50, 45)),
        body: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(15.0),
                child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[search, searchBtn],
                      shrinkWrap: true,
                    ))),
            resultText,
            resultStatusText,
            _addStatus ? addBtn : Container(),
            _responseStatus ? responseBtn : Container(),
          ],
        ));
  }
}
