import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/sign_in/sign_in_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
