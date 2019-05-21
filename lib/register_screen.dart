import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testapp/first_screen.dart';
import 'package:testapp/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

    final _formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final nameController = TextEditingController();
    final passwordController = TextEditingController();
    final Firestore firestore = Firestore.instance;
    Map<String, String> u = HashMap<String, String>();
   @override
  Widget build(BuildContext context) {
    //function
    void register(){
      if(this._formKey.currentState.validate()){
        var userUpdateInfo = new UserUpdateInfo(); //create user update object
        userUpdateInfo.displayName = nameController.text; // add Displayname
        FirebaseAuth auth = FirebaseAuth.instance;
        auth
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          ).then((FirebaseUser userc) => {
            userc.sendEmailVerification(),
            auth.currentUser().then((user)=>{
              user.updateProfile(userUpdateInfo),
              }).then((_)=>{
                u.putIfAbsent("email", ()=> emailController.text),
                u.putIfAbsent("name", ()=> nameController.text),
                this.firestore.collection("user").document(userc.uid).setData(u),
                auth.signOut(),
                Navigator.pushReplacement(context, 
                MaterialPageRoute(builder: (context) => FirstScreen()
              ))
            })
          }).catchError((onError)=>{
            Scaffold.of(_formKey.currentContext)
            .showSnackBar(SnackBar(
            content: Text(onError.toString()),
              )
            )
          });
      }
    }
    //component 
    final logo = Center(
      child:
      Text(
        "Register",
        style: TextStyle(fontSize: 50),
      )
    );
    final name = TextFormField(
      controller: nameController,
      keyboardType: TextInputType.text,
      autofocus: false,
      validator: (val){
        if(val.isEmpty)return 'Please fill in name';
        if(val.length > 20)return 'Please enter your display name in 20 characters';
      },
      decoration: InputDecoration(
        hintText: 'Please enter your name',
        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        prefixIcon: Icon(
          Icons.people
        )
      ),
    );
    final email = TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      validator: (val){
        if(val.isEmpty)return 'Please fill in email address';
        if(val.isEmpty)return 'Please fill in email address';
      },
      decoration: InputDecoration(
        hintText: 'email@example.com',
        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        prefixIcon: Icon(
          Icons.email
        )
      ),
    );

    final password = TextFormField(
      controller: passwordController,
      autofocus: false,
      obscureText: true,
      validator: (val){
        if(val.isEmpty)return 'Please fill in password';
        if(val.length < 6) return 'Please enter your password more than 6 character';
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
    final rePassword = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (val){
        if(val.isEmpty)return 'Please fill in password';
        if(val != passwordController.text)return 'Please enter re-password same password';
      },
      decoration: InputDecoration(
        hintText: 'Re-password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        prefixIcon: Icon(
          Icons.lock
        )
      ),
    );

    final registerBtn = Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: ()=> register(),
        padding: EdgeInsets.all(12),
        color: Colors.orangeAccent,
        child: Text('Sign Up', style: TextStyle(color: Colors.white)),
      ),
    );
    final loginText = Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0),
      child: FlatButton(
        child: 
        Text("Go to login"),
        onPressed:()=>{
          Navigator.push(context, 
          MaterialPageRoute(builder: (context) => LoginScreen())
          )
        }
        )
      );


    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 48.0),
              name,
              SizedBox(height: 8.0),
              email,
              SizedBox(height: 8.0),
              password,
              SizedBox(height: 8.0),
              rePassword,
              SizedBox(height: 24.0),
              registerBtn,
              loginText
            ],
          )
        ),
      ),
    );
  }
}