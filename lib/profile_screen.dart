import 'package:flutter/material.dart';
import 'bloc/appbar_bloc.dart';
import 'bloc/provider_bloc.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    print("page Profile");
    AppbarBloc appbarBloc = BlocProvider.of<AppbarBloc>(context);
    appbarBloc.setTitle("Profile");
   return Container(child: Text('Page 3')
    );
  }
}