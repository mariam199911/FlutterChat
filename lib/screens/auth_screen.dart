import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/aurth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;
  final _auth = FirebaseAuth.instance;
  void _submitAuthForm(String email, String password, String username,
      bool isSignup, BuildContext ctx) async {
    AuthResult _authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isSignup) {
        _authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        Firestore.instance
            .collection('users')
            .document(_authResult.user.uid)
            .setData({
          'username': username,
          'email': email,
        });
      } else {
        _authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, pelase check your credentials!';

      if (err.message != null) {
        message = err.message;
      }
      //print(err);
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: authForm(_submitAuthForm, _isLoading),
    );
  }
}
