import 'package:flutter/material.dart';
import 'bloc/appbar_bloc.dart';
import 'bloc/provider_bloc.dart';
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppbarBloc appbarBloc = BlocProvider.of<AppbarBloc>(context);
    appbarBloc.setTitle("Profile");
   return Container(child: Text('Page 3')
    );
  }
}