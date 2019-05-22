import 'package:testapp/bloc/provider_bloc.dart';
import 'dart:async';

class UserBloc implements BlocBase{
  String user;
  
  StreamController<String> streamControllerUser =  StreamController<String>.broadcast();
  UserBloc(){
    streamControllerUser.stream.listen(getUser);
  }
  getUser(String user){
    print(user);
  }
  setUser(String user) {
    user = user;
    streamControllerUser.sink.add(user);
  }
  @override
  void dispose() {
    streamControllerUser.close();
  }
}