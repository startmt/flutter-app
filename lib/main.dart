    
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
      color: Theme.of(context).backgroundColor,
      home: BlocProvider(
        bloc: AppbarBloc(),
        child: FirstScreen()
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
}