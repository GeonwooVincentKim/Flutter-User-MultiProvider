import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multiprovider/auths/firebase_auth.dart';
import 'package:flutter_multiprovider/models/my_user.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  FirebaseAuthService _auth;
  MyUser _myuser;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<FirebaseAuthService>(context, listen: false);
    _myuser = Provider.of<MyUser>(context, listen: false);
    return SafeArea(
      child: Scaffold(
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
              onPressed: () async {
                print(emailController.text);
                print(passController.text);
                final user = await _auth.signInEmailPW(
                    email: emailController.text, password: passController.text);
                if (user == null) {
                  print('로그인 실패');
                } else {
                  await firestore
                      .collection("users")
                      .doc(user.uid)
                      .get()
                      .then((value) {
                    _myuser.setName(value.data()["name"]);
                    _myuser.setCart(value.data()["cart"]);
                    print(value.data());
                  });
                  print('로그인 성공');
                  Navigator.of(context).pushReplacementNamed('/main');
                }
              },
              color: Colors.blue,
            ),
            RichText(
              text: TextSpan(
                text: 'Not a member yet? ',
                style: TextStyle(color: Colors.grey),
                children: [
                  TextSpan(
                    text: 'Sign Up',
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pushNamed('/signup');
                      },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
