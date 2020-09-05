import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/JellyfinAPI.dart';
import 'loginHelper.dart';

class PrivateUserSignIn extends StatefulWidget {
  const PrivateUserSignIn({Key key}) : super(key: key);

  @override
  _PrivateUserSignInState createState() => _PrivateUserSignInState();
}

class _PrivateUserSignInState extends State<PrivateUserSignIn> {
  bool isAuthenticating = false;

  String _username;
  String _password;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final jellyfinApiProvider = Provider.of<JellyfinAPI>(context);

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FractionallySizedBox(
            widthFactor: 0.9,
            child: TextFormField(
              decoration: InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Required";
                }
                return null;
              },
              onSaved: (newValue) => _username = newValue,
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
          FractionallySizedBox(
            widthFactor: 0.9,
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Required";
                }
                return null;
              },
              onSaved: (newValue) => _password = newValue,
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: isAuthenticating
                    ? null
                    : () async {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          setState(() {
                            isAuthenticating = true;
                          });
                          await loginHelper(
                              jellyfinApiProvider: jellyfinApiProvider,
                              username: _username,
                              password: _password,
                              context: context);
                          setState(() {
                            isAuthenticating = false;
                          });
                        }
                      },
                child:
                    isAuthenticating ? Text("Signing in...") : Text("Sign in"),
              ))
        ],
      ),
    );
  }
}