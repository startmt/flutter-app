import 'package:flutter/material.dart';
import 'bloc/appbar_bloc.dart';
import 'bloc/provider_bloc.dart';
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    AppbarBloc appbarBloc = BlocProvider.of<AppbarBloc>(context);
    print("page Chat");
    appbarBloc.setTitle("Chat");
    return Container(child: Text('Page 2')
    );
  }
}