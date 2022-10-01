import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otakusukejuru/services/auth_service.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    //Força esta tela a estar na vertical. Pode não funcionar em alguns dispositivos IOS.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    //Retorna a tela do programa em si.
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: const Color(0xff23272A),
        body: Stack(
          children: <Widget>[
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                // Da um espaço do topo da tela até o 1° widget retirar na hora de criar realmente essa tela
                padding: const EdgeInsets.only(
                  top: 100.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //botão de deslogar
                    TextButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        AuthService().signOut();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(250, 50),
                      ),
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          color: Color(0xFF2C2F33),
                          fontFamily: 'OpenSans',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
