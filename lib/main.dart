import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otakusukejuru/screens/app_is_without_internet.dart';
import 'package:otakusukejuru/services/auth_service.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      runApp(const MyApp(
        isInternetOn: true,
      ));
    }
  } on SocketException catch (_) {
    runApp(const MyApp(
      isInternetOn: false,
    ));
  }
}

class MyApp extends StatelessWidget {
  final bool isInternetOn;
  const MyApp({super.key, required this.isInternetOn});

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

    if (isInternetOn == false) {
      // Caso esteja sem internet manda para pagina especifica
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Otakusukejuru',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const AppWithoutInternet(),
      );
    } else {
      return MaterialApp(
        // Caso tenha internet o programa segue para a pagina de login ou a pagina de favoritos
        debugShowCheckedModeBanner: false,
        title: 'Otakusukejuru',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: AuthService().handleAuthState(),
      );
    }
  }
}
