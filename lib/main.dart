    
import 'package:flutter/material.dart';
import 'package:testapp/first_screen.dart';
import 'bloc/appbar_bloc.dart';
import 'bloc/provider_bloc.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Test App',
      home: BlocProvider(
        bloc: AppbarBloc(),
        child: FirstScreen()
        ),
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: 'Overpass'
        ),
      );
  }
}