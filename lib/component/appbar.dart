import 'package:flutter/material.dart';
import './appbaricon.dart';

class AppbarImplement {
  static getAppBar(String title, BuildContext context) {
    return PreferredSize(
      preferredSize: const Size(double.infinity, kToolbarHeight),
      child: AppBar(
        title: Text(title),
        actions: AppbarIcon.getAppBarIcon(title, context)
      ),
    );
  }
}
