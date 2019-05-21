import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testapp/bloc/appbar_bloc.dart';
import 'package:testapp/bloc/provider_bloc.dart';
import 'package:testapp/notlogin_screen.dart';

import 'mainpage_screen.dart';
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.currentUser().asStream(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
        if(snapshot.hasData){
          return MaterialApp(
          title: 'Test App',
          home: BlocProvider(
          bloc: AppbarBloc(),
          child: MainPageScreen()
            ),
          theme: ThemeData(
          primaryColor: Colors.orange,
          ),
          );
        }
        else{
          return NotLogin();
        }
      },
    );
  }
}