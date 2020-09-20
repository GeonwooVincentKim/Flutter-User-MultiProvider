import 'package:flutter/material.dart';
import 'package:flutter_multiprovider/screens/MainScreen.dart';
import 'package:flutter_multiprovider/screens/SigninScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SigninScreen(),
        '/main': (context) => MainScreen(),
      },
    );
  }
}
