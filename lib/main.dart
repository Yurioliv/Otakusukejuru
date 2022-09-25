import 'package:flutter/material.dart';
import 'package:otakusukejuru/screens/lost_password/lost_password_screen.dart';
import 'package:otakusukejuru/screens/lost_username/lost_username_screen.dart';
import 'package:otakusukejuru/screens/sign_up/sign_up_screen.dart';
import 'screens/sign_in/sign_in_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Otakusukejuru',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const SignInScreen(),
    );
  }
}
