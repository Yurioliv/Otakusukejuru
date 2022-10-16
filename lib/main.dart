import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otakusukejuru/services/auth_service.dart';

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
    // Esconde a barra inferior do android
    // Arrastando para cima na area da barra faz ela reaparecer
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    //Força esta tela a estar na vertical. Pode não funcionar em alguns dispositivos IOS.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Otakusukejuru',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: AuthService().handleAuthState(),
    );
  }
}
