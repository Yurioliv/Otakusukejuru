import 'package:flutter/material.dart';
import 'package:otakusukejuru/components/drawer_for_pages.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  // Nome que sera apresentado na APPBAR
  static const String pageName = 'Favoritos';

  @override
  Widget build(BuildContext context) {
    //Retorna a tela do programa em si.
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: const Color(0xff2C2F33),
        // Appbar do scaffold
        appBar: AppBar(
          backgroundColor: const Color(0xff23272A),
          title: const Text(
            pageName,
            style: TextStyle(fontSize: 24.0),
          ),
          // TODO adicionar funções nos gestureDetectors abaixo
          actions: [
            GestureDetector(
              onTap: () {},
              child: const Icon(Icons.search, size: 32.0),
            ),
            const SizedBox(
              width: 15,
            ),
            GestureDetector(
              onTap: () {},
              child: const Icon(Icons.label, size: 32.0),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        // Drawer do scaffold
        drawer: const DrawerForPages(),
        // Body do scaffold
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
                // TODO criar lista de animes em um grid abaixo
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
