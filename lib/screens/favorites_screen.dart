import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otakusukejuru/components/color_of_marcation.dart';
import 'package:otakusukejuru/components/drawer_for_pages.dart';
import 'package:otakusukejuru/screens/anime_screen.dart';
import 'package:otakusukejuru/screens/manga_screen.dart';

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
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("Users").snapshots(),
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
                var indexUser;
                var indexObra = [];
                var obraEpisodioOuCapitulo;

                if (tipoPagina == "Animes") {
                  obraEpisodioOuCapitulo = "Episodio";
                } else {
                  obraEpisodioOuCapitulo = "Capitulo";
                }

                // Pega index do usuario atual
                for (int i = 0; i < snapshoot.data!.size; i++) {
                  if (snapshoot.data!.docs[i].id ==
                      FirebaseAuth.instance.currentUser?.uid) {
                    indexUser = i;
                  }
                }

                return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection(tipoPagina)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshoot2) {
                      if (snapshoot2.hasError) {
                        return Text('error: ${snapshoot2.error}');
                      }
                      switch (snapshoot2.connectionState) {
                        case ConnectionState.waiting:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        default:

                          // Pega index do anime atual
                          for (int i = 0;
                              i <
                                  snapshoot.data!.docs[indexUser]
                                      .get('$tipoPagina favoritos')
                                      .length;
                              i++) {
                            for (int j = 0; j < snapshoot2.data!.size; j++) {
                              if (snapshoot.data!.docs[indexUser]
                                      .get('$tipoPagina favoritos')[i]["Id"] ==
                                  snapshoot2.data!.docs[j].id) {
                                indexObra.add(j);
                              }
                            }
                          }
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.5,
                            ),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshoot.data!.docs[indexUser]
                                .get('$tipoPagina favoritos')
                                .length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(
                                        mediaquery.size.width * 0.022),
                                    child: GestureDetector(
                                      // TODO precisa mudar pois a snapshoot agora é outra
                                      onTap: tipoPagina == "Animes"
                                          ? () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AnimeScreen(
                                                        snapshot: snapshoot2
                                                            .data!.docs
                                                            .elementAt(
                                                                indexObra[
                                                                    index]),
                                                      )))
                                          : () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MangaScreen(
                                                          snapshot: snapshoot2
                                                              .data!.docs
                                                              .elementAt(
                                                                  indexObra[
                                                                      index])))),
                                      child: GridTile(
                                        child: Column(
                                          children: <Widget>[
                                            SizedBox(
                                              child: Image.network(
                                                // TODO fazer retornar a imagem comparando com o id que tem no favoritos do usuario

                                                snapshoot2.data!.docs
                                                    .elementAt(indexObra[index])
                                                    .get("Url capa"),
                                                loadingBuilder:
                                                    (BuildContext contex,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
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
                                              snapshoot2.data!.docs
                                                  .elementAt(indexObra[index])
                                                  .get("Nome"),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                            // Mostra o episodio/capitulo atual do usuario
                                            PopupMenuButton(
                                              itemBuilder: (Context) => [
                                                for (int i = 1;
                                                    i <=
                                                        snapshoot2.data!.docs
                                                            .elementAt(
                                                                indexObra[
                                                                    index])
                                                            .get(
                                                                "Ultimo $obraEpisodioOuCapitulo");
                                                    i++) ...[
                                                  // Remove item no firebase
                                                  PopupMenuItem(
                                                      onTap: () async {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection("Users")
                                                            .doc(FirebaseAuth
                                                                .instance
                                                                .currentUser
                                                                ?.uid)
                                                            .update({
                                                          "$tipoPagina favoritos":
                                                              FieldValue
                                                                  .arrayRemove([
                                                            {
                                                              "Id": snapshoot
                                                                      .data!
                                                                      .docs[
                                                                          indexUser]
                                                                      .get(
                                                                          '$tipoPagina favoritos')[
                                                                  index]["Id"],
                                                              "$obraEpisodioOuCapitulo Atual": snapshoot
                                                                      .data!
                                                                      .docs[
                                                                          indexUser]
                                                                      .get(
                                                                          '$tipoPagina favoritos')[index]
                                                                  [
                                                                  "$obraEpisodioOuCapitulo Atual"]
                                                            }
                                                          ])
                                                        });
                                                        // Recria o item agora atualizado no firebase
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection("Users")
                                                            .doc(FirebaseAuth
                                                                .instance
                                                                .currentUser
                                                                ?.uid)
                                                            .update({
                                                          "$tipoPagina favoritos":
                                                              FieldValue
                                                                  .arrayUnion([
                                                            {
                                                              "Id": snapshoot
                                                                      .data!
                                                                      .docs[
                                                                          indexUser]
                                                                      .get(
                                                                          '$tipoPagina favoritos')[
                                                                  index]["Id"],
                                                              "$obraEpisodioOuCapitulo Atual":
                                                                  i
                                                            }
                                                          ])
                                                        });
                                                      },
                                                      child: Text(
                                                          "$obraEpisodioOuCapitulo $i"))
                                                ]
                                              ],
                                              // Mostra episodio/capitulo atual
                                              child: Container(
                                                color: Colors.white,
                                                height: mediaquery.size.height *
                                                    0.03,
                                                width:
                                                    mediaquery.size.width * 0.3,
                                                child: Center(
                                                  child: Text(
                                                    '$obraEpisodioOuCapitulo ${snapshoot.data!.docs[indexUser].get('$tipoPagina favoritos')[index]["$obraEpisodioOuCapitulo Atual"]}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Mostra o numero do ultimo episodio/capitulo e cor de acordo com a data
                                            SizedBox(
                                                height: mediaquery.size.height *
                                                    0.005),
                                            Container(
                                              color: colorForMarcation(snapshoot2
                                                  .data!.docs
                                                  .elementAt(indexObra[index])
                                                  .get(
                                                      "Data Ultimo $obraEpisodioOuCapitulo")),
                                              height:
                                                  mediaquery.size.height * 0.03,
                                              width:
                                                  mediaquery.size.width * 0.3,
                                              child: Center(
                                                child: Text(
                                                  snapshoot2.data!.docs
                                                      .elementAt(
                                                          indexObra[index])
                                                      .get(
                                                          "Ultimo $obraEpisodioOuCapitulo")
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            )
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
                    });
            }
          },
        ),
      ),
    );
  }
}
