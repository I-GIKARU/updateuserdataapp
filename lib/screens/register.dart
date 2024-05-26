// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import '../services/auth.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onLoginClicked;

  const RegisterScreen({required this.onLoginClicked});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final Authentication _auth = Authentication();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurpleAccent,
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Register',
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
                      TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name cannot be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
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
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            child: Text('Sign Up'),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                createUser();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.deepPurpleAccent, backgroundColor: Colors.white,
                            ),
                          ),
                          ElevatedButton(
                            child: Text('Cancel'),
                            onPressed: widget.onLoginClicked,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.deepPurpleAccent, backgroundColor: Colors.white,
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

  void createUser() async {
    dynamic result = await _auth.createNewUser(
        _nameController.text, _emailController.text, _passwordController.text);
    if (result == null) {
      print('Email is not valid');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration error. Please try again.')),
      );
    } else {
      print(result.toString());
      _nameController.clear();
      _passwordController.clear();
      _emailController.clear();
      widget.onLoginClicked();
    }
  }
}
