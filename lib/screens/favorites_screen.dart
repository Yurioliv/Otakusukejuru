import 'package:cloud_firestore/cloud_firestore.dart';
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
  String tipoPagina = "Animes";

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
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
          iconTheme: const IconThemeData(
            size: 32,
            color: Colors.white,
          ),
          // TODO adicionar funções nos gestureDetectors abaixo
          actions: [
            GestureDetector(
              onTap: () {},
              child: const Icon(Icons.search),
            ),
            SizedBox(
              width: mediaquery.size.width * 0.04,
            ),
            GestureDetector(
              onTap: () {},
              child: const Icon(Icons.label),
            ),
            SizedBox(
              width: mediaquery.size.width * 0.04,
            ),
          ],
        ),
        // Bottom bar do Scaffold
        bottomNavigationBar: BottomAppBar(
          color: const Color(0xff23272A),
          child: SizedBox(
            height: mediaquery.size.height * 0.07,
            width: mediaquery.size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Botão animes
                SizedBox(
                  width: mediaquery.size.width * 0.49,
                  child: GestureDetector(
                    onTap: () => setState(() {
                      tipoPagina = "Animes";
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: mediaquery.size.width * 0.49,
                          child: const Text(
                            "Animes",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Divisores de espaço entre botões
                VerticalDivider(
                  color: const Color(0xff2C2F33),
                  width: mediaquery.size.width * 0.02,
                ),
                // Botão mangas
                SizedBox(
                  width: mediaquery.size.width * 0.49,
                  child: GestureDetector(
                    onTap: () => setState(() {
                      tipoPagina = "Mangas";
                    }),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: mediaquery.size.width * 0.49,
                          child: const Text(
                            "Mangas",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
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
        ),
        // Drawer do scaffold
        drawer: const DrawerForPages(),
        // Body do scaffold
        // TODO criar lista de animes em um grid abaixo
        body: Container(),
      ),
    );
  }
}
