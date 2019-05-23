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
              textTheme: TextTheme(
                title: TextStyle(fontSize: 20,),
                body1: TextStyle(fontSize: 17 ),
                body2: TextStyle(fontSize: 10,color: Colors.black38,fontWeight: FontWeight.w300),
                display1: TextStyle(fontSize: 16),
                display2: TextStyle(fontSize: 16),
                caption: TextStyle(fontSize: 12),
                display3: TextStyle(fontSize: 20),
                button: TextStyle(fontSize: 18),
                display4: TextStyle(fontSize: 20),
                headline: TextStyle(fontSize: 20),
                subtitle: TextStyle(fontSize: 20),
                overline: TextStyle(fontSize: 20),
                subhead: TextStyle(fontSize: 16) //text field
              ),
              primaryColor: Colors.orangeAccent,
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