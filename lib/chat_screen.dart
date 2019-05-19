import 'package:flutter/material.dart';
import 'bloc/appbar_bloc.dart';
import 'bloc/provider_bloc.dart';
class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppbarBloc appbarBloc = BlocProvider.of<AppbarBloc>(context);
    appbarBloc.setTitle("Chat");
    return Container(child: Text('Page 2')
    );
  }
}