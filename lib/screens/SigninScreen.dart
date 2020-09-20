import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Column(
        children: [
          Container(
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'example@email.com',
                helperText: 'E-Mail',
              ),
            ),
            padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
          ),
          Container(
            child: TextFormField(
              controller: passController,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'password',
                helperText: 'Password',
              ),
            ),
            padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
          ),
          FlatButton(
            child: Text(
              'Sign In',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              print(emailController.text);
              print(passController.text);
            },
            color: Colors.blue,
          ),
          RichText(
            text: TextSpan(
              text: 'Not a member yet? ',
              style: TextStyle(color: Colors.grey),
              children: [
                TextSpan(text: 'Sign in', style: TextStyle(color: Colors.blue))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
