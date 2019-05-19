import 'package:flutter/material.dart';

class AppbarImplement {
  static getAppBar(String title) {
    return PreferredSize(
      preferredSize: const Size(double.infinity, kToolbarHeight),
      child: AppBar(
        title: Center(child: Text(title)),
        actions: <Widget>[
          Icon(Icons.search),
        ],
      ),
    );
  }
}
