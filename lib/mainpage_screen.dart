import 'package:flutter/material.dart';

import 'bloc/appbar_bloc.dart';
import 'bloc/provider_bloc.dart';
import 'component/appbar.dart';
import 'component/tabbar.dart';
class MainPageScreen extends StatefulWidget {
  @override
  _MainPageScreenState createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  @override
  Widget build(BuildContext context) {
    
    final AppbarBloc appbarBloc = BlocProvider.of<AppbarBloc>(context);
    return Scaffold(
      appBar: PreferredSize(child: StreamBuilder(
        stream: appbarBloc.streamControllerTitle.stream,
        initialData: '',
        builder: (context, snapshot){
          print("title " + snapshot.data.toString());
          return AppbarImplement.getAppBar(snapshot.data.toString());
        },
      ),
      preferredSize: const Size(50, 45)),
      body: MyTabBar()
    );
  }
}