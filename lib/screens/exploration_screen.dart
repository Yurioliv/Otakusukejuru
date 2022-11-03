import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:otakusukejuru/components/drawer_for_pages.dart';
import 'package:otakusukejuru/screens/anime_screen.dart';
import 'package:otakusukejuru/screens/manga_screen.dart';

class ExplorationScreen extends StatefulWidget {
  const ExplorationScreen({super.key});

  @override
  State<ExplorationScreen> createState() => _ExplorationScreenState();
}

class _ExplorationScreenState extends State<ExplorationScreen> {
  // Nome que sera apresentado na APPBAR
  static const String pageName = 'Explorar';
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
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection(tipoPagina).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshoot) {
            if (snapshoot.hasError) {
              return Text('error: ${snapshoot.error}');
            }
            switch (snapshoot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.62,
                  ),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshoot.data?.docs.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.all(mediaquery.size.width * 0.022),
                          child: GestureDetector(
                            onTap: tipoPagina == "Animes"
                                ? () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AnimeScreen(
                                              snapshot: snapshoot.data!.docs
                                                  .elementAt(index),
                                            )))
                                : () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MangaScreen(
                                            snapshot: snapshoot.data!.docs
                                                .elementAt(index)))),
                            child: GridTile(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    child: Image.network(
                                      snapshoot.data!.docs
                                          .elementAt(index)
                                          .get("Url capa"),
                                      loadingBuilder: (BuildContext contex,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    snapshoot.data!.docs
                                        .elementAt(index)
                                        .get("Nome"),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
