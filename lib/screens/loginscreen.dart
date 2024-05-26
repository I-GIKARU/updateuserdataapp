// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onRegisterClicked;

  LoginScreen({required this.onRegisterClicked});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final Authentication _auth = Authentication();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurple,
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email cannot be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.white),
                          errorStyle: TextStyle(color: Colors.red),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password cannot be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                          errorStyle: TextStyle(color: Colors.red),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      TextButton(
                        child: Text('Not registered? Sign up'),
                        onPressed: widget.onRegisterClicked,
                        style: TextButton.styleFrom(foregroundColor: Colors.white),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            child: Text('Login'),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                signInUser();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.deepPurple, backgroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signInUser() async {
    dynamic authResult =
    await _auth.loginUser(_emailController.text, _passwordController.text);
    if (authResult == null) {
      print('Sign in error. Could not log in');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign in error. Could not log in')),
      );
    } else {
      _emailController.clear();
      _passwordController.clear();
      Navigator.pushNamed(context, '/dashboard');
    }
  }
}
