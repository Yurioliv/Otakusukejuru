import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otakusukejuru/components/drawer_for_pages.dart';

class ExplorationScreen extends StatefulWidget {
  const ExplorationScreen({super.key});

  @override
  State<ExplorationScreen> createState() => _ExplorationScreenState();
}

class _ExplorationScreenState extends State<ExplorationScreen> {
  // Nome que sera apresentado na APPBAR
  static const String pageName = 'Explorar';

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
