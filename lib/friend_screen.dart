import 'package:flutter/material.dart';
import 'package:testapp/bloc/friend_bloc.dart';
import 'package:testapp/component/friendtemplate.dart';

import 'bloc/appbar_bloc.dart';
import 'bloc/provider_bloc.dart';

class FriendScreen extends StatefulWidget {
  @override
  _FriendScreenState createState() => _FriendScreenState();
  
}

class _FriendScreenState extends State<FriendScreen> {
  @override
  Widget build(BuildContext context) {
    AppbarBloc appbarBloc = BlocProvider.of<AppbarBloc>(context);
    appbarBloc.setTitle("Friend");
    return BlocProvider(
      bloc: FriendBloc(),
      child: FriendTemplate(),
    );
  }
}