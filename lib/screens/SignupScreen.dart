import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multiprovider/auths/firebase_auth.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passController = TextEditingController();
  final passConfirmController = TextEditingController();
  FirebaseAuthService _auth;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passController.dispose();
    passConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<FirebaseAuthService>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
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
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Your name',
                  helperText: 'Name',
                ),
              ),
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
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
              padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            ),
            Container(
              child: TextFormField(
                controller: passConfirmController,
                validator: (val) {
                  if (passConfirmController.text
                          .compareTo(passController.text) !=
                      0) {
                    print('Wrong Password');
                    return '';
                  }
                  return null;
                },
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'confirm password',
                  helperText: 'Confirm Password',
                ),
              ),
              padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
            ),
            FlatButton(
              child: Text(
                'Sign Up',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                print(emailController.text);
                print(passController.text);
                final user = await _auth.signUpEmailPW(
                    email: emailController.text, password: passController.text);
                if (user == null) {
                  print('회원가입 실패');
                } else {
                  String uid = user.uid;
                  String name = nameController.text;
                  List<int> cart = [];
                  await firestore.collection("users").doc(uid).set({
                    "name": name,
                    "cart": cart,
                  }).then((value) {
                    print('회원가입 성공');
                    Navigator.of(context).pop();
                  });
                }
              },
              color: Colors.blue,
            ),
            OutlineButton(
              splashColor: Colors.grey,
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              highlightElevation: 0,
              borderSide: BorderSide(color: Colors.grey),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                        image: AssetImage("images/google_logo.png"),
                        height: 35.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign up with Google',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
