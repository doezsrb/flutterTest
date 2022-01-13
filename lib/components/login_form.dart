import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key, required this.login}) : super(key: key);
  Function(String, String) login;
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String username;
  late String password;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Username',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter username';
                }
                username = value;
                return null;
              },
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password';
                }
                password = value;
                return null;
              },
            ),
            Expanded(
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.login(username, password);
                        } else {
                          print("error");
                        }
                      },
                      child: const Text('Submit'))),
            )
          ],
        ),
      ),
    );
  }
}
