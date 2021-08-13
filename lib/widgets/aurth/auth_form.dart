import 'package:flutter/material.dart';

class authForm extends StatefulWidget {
  authForm(this._submit, this.isLoading);
  final bool isLoading;
  final void Function(String email, String password, String username,
      bool isSignup, BuildContext ctx) _submit;
  @override
  _authFormState createState() => _authFormState();
}

class _authFormState extends State<authForm> {
  final _formKey = GlobalKey<FormState>();
  bool _signUp = false;
  void signUp() {
    setState(() {
      _signUp = !_signUp;
    });
  }

  String _email = '';
  String _password = '';
  String _username = '';
  void _tryToSubmit() {
    final _formState = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (_formState) {
      _formKey.currentState.save();
      //   print(_email);
      //   print(_password);
      //   print(_username);
      widget._submit(
          _email.trim(), _password.trim(), _username.trim(), _signUp, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) {
                      _email = value;
                    },
                  ),
                  if (_signUp)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'Please enter a valid Username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Username'),
                      onSaved: (value) {
                        _username = value;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Please enter a valid password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                  // if (_signUp == true)
                  //   TextFormField(
                  //     validator: (value) {
                  //       if (value.isEmpty || value.length < 7) {
                  //         return 'Please enter a valid password';
                  //       }
                  //       return null;
                  //     },
                  //     decoration:
                  //         InputDecoration(labelText: 'Confirm Password'),
                  //     obscureText: true,
                  //   ),
                  SizedBox(
                    height: 20,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      onPressed: _tryToSubmit,
                      child: Text(_signUp ? 'Signup' : 'Log in'),
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: signUp,
                      child: Text(
                        (_signUp
                            ? 'I already have an account'
                            : 'Create new account'),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
