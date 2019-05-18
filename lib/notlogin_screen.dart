import 'package:flutter/material.dart';

class NotLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final signinButton = FlatButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, "/main");
      },
      child: Text('Sign in')
      );
    return Scaffold(
      body: 
      Center( 
        child: signinButton,  
      )
      );
  }
}