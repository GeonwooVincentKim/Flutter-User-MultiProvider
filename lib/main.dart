import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multiprovider/auths/firebase_auth.dart';
import 'package:flutter_multiprovider/screens/MainScreen.dart';
import 'package:flutter_multiprovider/screens/SigninScreen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().whenComplete(() => print('Init Firebase'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(),
        )
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
