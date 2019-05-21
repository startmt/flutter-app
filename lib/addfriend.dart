import 'package:flutter/material.dart';
import 'package:testapp/dto/userdata.dart';

import 'bloc/appbar_bloc.dart';
import 'bloc/provider_bloc.dart';
import 'component/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddFriendScreen extends StatefulWidget {
  @override
  _AddFriendScreenState createState() => _AddFriendScreenState();
  
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final Firestore firestore = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  final searchController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  
  bool _searchStatus = false;
  userData resultData = userData();
  @override
  Widget build(BuildContext context) {

    final AppbarBloc appbarBloc = BlocProvider.of<AppbarBloc>(context);
    searchUser(){
      String _searchTxt = searchController.text;
      if(this._formKey.currentState.validate()){
        firestore.collection('user')
        .where('email', isEqualTo: _searchTxt)
        .getDocuments()
        .then((val)=>{
          setState(() {
            _searchStatus = true;
            print(_searchStatus);
          }),
          resultData.setUserData(val.documents[0].data['name'], val.documents[0].data['email'])
        }).catchError((err)=>{
          setState(() {
            _searchStatus = false;
            resultData.setUserData("Not found", "Not found");
          }),
        });
      }
    }

  Future<DocumentReference> getFriendref() async {
    String _searchTxt = searchController.text;
    Future<QuerySnapshot> doc = firestore.collection('user')
        .where('email', isEqualTo: _searchTxt)
        .getDocuments();
    // doc.then((ref)=>{print("doc = " + ref.documents[0].metadata.toString())});
    doc.then((onValue)=>{print(onValue.documents[0].metadata)});
    DocumentReference ref = firestore.collection('user').document();
    return ref;
  }
  addFriend() async{
    FirebaseUser user = await auth.currentUser();
    Future<DocumentReference> ref = getFriendref();
    print(ref);
  }
    final search = TextFormField(
      controller: searchController,
      keyboardType: TextInputType.emailAddress,
      validator: (val){
        if(val.isEmpty) return "please fill in email";
        if(RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) == false) return "please enter correct email format";
      },
      decoration: InputDecoration(
        hintText: 'Please enter your email friend',
        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        suffixIcon: 
        Icon(
          Icons.search
        ),
      ),
    );
  
  final searchBtn = RaisedButton(
    onPressed: searchUser,
    child: Text("Search")
    );
  
  final resultText = Container(
    child: Text(resultData.name));
  final addBtn = RaisedButton(
    onPressed: ()=>addFriend(),
    color: Colors.green,
    child: Text("Add")
  );

    return Scaffold(
      appBar: PreferredSize(child: StreamBuilder(
        stream: appbarBloc.streamControllerTitle.stream,
        initialData: 'Add Friend',
        builder: (context, snapshot){
          return AppbarImplement.getAppBar(snapshot.data.toString(), context);
        },
      ),
      preferredSize: const Size(50, 45)),
      body: Column(
        children: <Widget>[
          Container(
          padding: EdgeInsets.all(15.0),
          child: 
          Form(
            key: _formKey,
            child: ListView(children: <Widget>[
              search,searchBtn
            ],
            shrinkWrap: true,
          )
        )
      ),
       resultText,
       _searchStatus? addBtn:Container()
      ],
      )
      
    );
  }
}