import 'package:flutter/material.dart';
import 'package:testapp/login_screen.dart';
class NotLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final signinButton = FlatButton(
      onPressed: () {
        Navigator.pushReplacement(context,
         MaterialPageRoute(builder: (context) => LoginScreen()
         )
        );
      },
      child: Text('Sign in')
      );
      
    return Scaffold(
      body: 
      Center( 
        child: ListView(children: <Widget>[signinButton],),
      )
      );
  }
}