import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:otakusukejuru/services/auth_service.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),

            //botão de deslogar
            TextButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                AuthService().signOut();
              },
              //TODO colocar função para deslogar
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
    );
  }
}
