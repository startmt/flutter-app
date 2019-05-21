import 'package:testapp/bloc/provider_bloc.dart';
import 'dart:async';

class UserBloc implements BlocBase{
  String title;
  
  StreamController<String> streamControllerUser =  StreamController<String>.broadcast();
  UserBloc(){
    streamControllerUser.stream.listen(getUser);
  }
  getUser(String title){
    print(title);
  }
  setUser(String User) {
    User = User;
    streamControllerUser.sink.add(User);
  }
  @override
  void dispose() {
    streamControllerUser.close();
  }
}