import 'package:flutter/material.dart';
import 'package:testapp/bloc/appbar_bloc.dart';
import 'package:testapp/bloc/provider_bloc.dart';
import 'mainpage_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  
 
  @override
  Widget build(BuildContext context) {
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
  }