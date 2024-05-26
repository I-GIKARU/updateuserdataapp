// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'loginscreen.dart';
import 'register.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _showLogin = true;

  void _toggleScreens() {
    setState(() {
      _showLogin = !_showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showLogin
        ? LoginScreen(onRegisterClicked: _toggleScreens)
        : RegisterScreen(onLoginClicked: _toggleScreens);
  }
}
