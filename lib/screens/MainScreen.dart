import 'package:flutter/material.dart';
import 'package:flutter_multiprovider/auths/firebase_auth.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  FirebaseAuthService _auth;
  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<FirebaseAuthService>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Main Screen'),
        ),
        body: Center(
          child: Text('Main Screen'),
        ),
      ),
    );
  }
}
