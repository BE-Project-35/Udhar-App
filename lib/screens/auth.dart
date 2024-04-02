// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:udhar_app/widgets/user_image_picker.dart';
import '../services/auth_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthService authService = AuthService();
  final _form = GlobalKey<FormState>();
  var _isLogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  File? _selectedImage;
  var _isAuthenticating = false;
  Future<void> _submit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid || !_isLogin && _selectedImage == null) {
      return;
    }

    _form.currentState!.save();
    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (_isLogin) {
        //login code
        // final userCredentials = await _firebase.signInWithEmailAndPassword(
        //     email: _enteredEmail, password: _enteredPassword);
        // print(userCredentials);
        authService.login(_enteredEmail, _enteredPassword);
      } else {
        //signup code

        authService.signup(_enteredEmail, _enteredPassword, _selectedImage);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        // ..
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Authentication falied'),
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    }

    // if(_isLogin)
    // {
    //   //login code
    //   final userCredentials=await _firebase.signInWithEmailAndPassword(
    //     email: _enteredEmail, password: _enteredPassword);
    // }else{
    //   //signup code
    //   try {
    //       final userCredentials= await _firebase.createUserWithEmailAndPassword(
    //              email: _enteredEmail, password: _enteredPassword);
    //              print(userCredentials);
    //       } on FirebaseAuthException catch (e) {
    //           if(e.code=='email-already-in-use')
    //           {
    //               // ..
    //           }
    //           ScaffoldMessenger.of(context).clearSnackBars();
    //           ScaffoldMessenger.of(context).showSnackBar(
    //             SnackBar(content: Text(e.message ?? 'Authentication falied'),
    //             ),
    //           );
    //       }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0x00d7a31a),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 30,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Image.asset('assets/images/udhar_logo.png'),
                ),
                Card(
                  color: Color.fromRGBO(58, 66, 86, 1.0),
                  margin: const EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: _form,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (!_isLogin)
                              UserImagePicker(
                                onPickImage: (pickedImage) {
                                  _selectedImage = pickedImage;
                                },
                              ),
                            TextFormField(
                              decoration: const InputDecoration(
                                  labelStyle: TextStyle(color: Colors.white),
                                  hoverColor: Colors.white,
                                  labelText: 'Email Address'),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@')) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredEmail = value!;
                              },
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                hoverColor: Colors.white,
                                labelText: 'Password',
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return 'Password must be 6 characters long';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredPassword = value!;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (_isAuthenticating)
                              const CircularProgressIndicator()
                            else if (!_isAuthenticating)
                              ElevatedButton(
                                onPressed: () {
                                  _submit();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                ),
                                child: Text(
                                  _isLogin ? 'login' : 'Sign Up',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            if (!_isAuthenticating)
                              TextButton(
                                child: Text(
                                  _isLogin
                                      ? 'Create an account'
                                      : 'I already have an account,Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                },
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
