import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testapp/first_screen.dart';
import 'package:testapp/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

   @override
  Widget build(BuildContext context) {
    void login(){
      print(this._formKey.currentState);
      FirebaseAuth auth = FirebaseAuth.instance;
      if(_formKey.currentState.validate()){
        auth
        .signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
        ).then((FirebaseUser user){
          if (user.isEmailVerified) {
            Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=> FirstScreen()
            ));
            
          } else {
            Scaffold.of(_formKey.currentContext)
            .showSnackBar(SnackBar(
            content: Text("Please verified your email"),
          ));
            auth.signOut();
        }
        }).catchError((onError){
            Scaffold.of(_formKey.currentContext)
            .showSnackBar(SnackBar(
            content: Text(onError.toString()),
          )
        );
        });
      }else{
        Scaffold.of(_formKey.currentContext).showSnackBar(SnackBar(
          content: Text("Please fill in all field "),
          ));
      }
    }
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );
   
    final email = TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      validator: (val){
        if(val.isEmpty)return 'Please fill in email address';
      },
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        prefixIcon: Icon(
          Icons.people
        )
      ),
    );

    final password = TextFormField(
      controller: passwordController,
      autofocus: false,
      obscureText: true,
      validator: (val){
        if(val.isEmpty)return 'Please fill in password';
      },
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        prefixIcon: Icon(
          Icons.lock
        )
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () => login(),
        padding: EdgeInsets.all(12),
        color: Colors.orangeAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );
    final createUser = Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: FlatButton(
        child: 
        Text("Create your account"),
        onPressed:()=>{
          Navigator.push(context, 
          MaterialPageRoute(builder: (context) => RegisterScreen())
          )
        }
        )
      );


    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            createUser
          ],
        )
        ),
      ),
    );
  }
}
