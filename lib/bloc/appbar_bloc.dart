import 'package:testapp/bloc/provider_bloc.dart';
import 'dart:async';

class AppbarBloc implements BlocBase{
  String title;
  
  StreamController<String> streamControllerTitle =  StreamController<String>.broadcast();
  AppbarBloc(){
    streamControllerTitle.stream.listen(getTitle);
  }
  getTitle(String title){
    return title;
  }
  setTitle(String title) {
    title = title;
    streamControllerTitle.sink.add(title);
  }
  @override
  void dispose() {
    streamControllerTitle.close();
  }
}