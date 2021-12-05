import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:movlog/views/homeScreen.dart';
import 'package:movlog/views/signUpScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Paint.enableDithering = true;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MovLog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUp(),
    );
  }
}

