import 'package:flutter/material.dart';
import 'package:testapp/notlogin_screen.dart';
import 'bloc/appbar_bloc.dart';
import 'bloc/provider_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    AppbarBloc appbarBloc = BlocProvider.of<AppbarBloc>(context);
    auth.currentUser().then((user) =>{
      appbarBloc.setTitle("Setting")
    });
    signout(){
      auth.signOut();
      Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (context)=> NotLogin()
      ));
    }
    final signoutBtn = RaisedButton(
      onPressed: signout,
       padding: EdgeInsets.all(12),
       color: Colors.grey,
       child: Text('Sign out', style: TextStyle(color: Colors.white)));
    
   return Scaffold(
     body: ListView(
       children: <Widget>[
         signoutBtn
       ],
     )
   );
  }
}