import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otakusukejuru/components/color_of_marcation.dart';
import 'package:otakusukejuru/components/drawer_for_pages.dart';
import 'package:otakusukejuru/components/search_textfield.dart';
import 'package:otakusukejuru/screens/anime_screen.dart';
import 'package:otakusukejuru/screens/manga_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  // Nome que sera apresentado na APPBAR
  static const String pageName = 'Favoritos';
  String tipoPagina = "Animes";

  // Variavel que informa se a função de pesquisa por nome esta selecionada
  var isNameSearchSelected = false;
  final _NameSeachController = TextEditingController();
  String _NameForSearch = "";
  // Variavel que informa se a função de pesquisa por genero esta selecionada
  var isGenreSearchSelected = false;
  List<String> genreList = [];

  final List<String> genres = [
    "Ação",
    "Aventura",
    "Seinen",
    "Historica",
    "Militar",
    "Publico Adulto",
    "Shounen",
    "Comédia",
    "Escolar",
    "Romance",
    "Sobrenatural",
    "Horror",
    "Esportes",
    "Super Poderes",
    "Artes Marciais",
    "Fantasia"
  ];

  @override
  void initState() {
    super.initState();
    _NameSeachController.addListener((_updateNameForSearch));
  }

  @override
  void dispose() {
    _NameSeachController.dispose();
    super.dispose();
  }

  void _updateNameForSearch() {
    setState(() {
      _NameForSearch = _NameSeachController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);

    //Retorna a tela do programa em si.
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        key: _key,
        backgroundColor: const Color(0xff2C2F33),
        // Appbar do scaffold
        appBar: AppBar(
          backgroundColor: const Color(0xff23272A),
          title: isNameSearchSelected
              ? SearchTextField(controlador: _NameSeachController)
              : isGenreSearchSelected
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$pageName $tipoPagina",
                          style: const TextStyle(fontSize: 22.0),
                        ),
                        Text(
                          genreList
                              .toString()
                              .replaceAll("[", "")
                              .replaceAll(']', ""),
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    )
                  : Text(
                      "$pageName $tipoPagina",
                      style: const TextStyle(fontSize: 24.0),
                    ),
          iconTheme: const IconThemeData(
            size: 32,
            color: Colors.white,
          ),
          // TODO adicionar funções nos gestureDetectors abaixo, talvez tenha que diminuir espaço entre icones
          actions: [
            if (isNameSearchSelected == true ||
                isGenreSearchSelected == true) ...[
              GestureDetector(
                onTap: () {
                  setState(() {
                    isNameSearchSelected = false;
                    isGenreSearchSelected = false;
                    genreList = [];
                    _NameSeachController.text = "";
                  });
                },
                child: const Icon(Icons.close),
              ),
              SizedBox(
                width: mediaquery.size.width * 0.04,
              ),
            ],
            GestureDetector(
              onTap: () {
                setState(() {
                  isNameSearchSelected = true;
                });
              },
              child: const Icon(Icons.search),
            ),
            SizedBox(
              width: mediaquery.size.width * 0.04,
            ),
            GestureDetector(
              onTap: () {
                _key.currentState!.openEndDrawer();
              },
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
        // Drawer da direita do scaffold
        endDrawer: SizedBox(
          width: mediaquery.size.width * 0.6,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                for (int i = 0; i < genres.length; i++) ...[
                  // ListTile com um genero
                  Container(
                    color: genreList.contains(genres[i])
                        ? const Color(0xFF7289DA)
                        : const Color(0xff23272A),
                    child: ListTile(
                      title: Text(
                        genres[i],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onTap: () {
                        // Adicionando ou removendo genero da lista
                        if (genreList.contains(genres[i])) {
                          setState(() {
                            genreList.remove(genres[i]);
                          });
                        } else {
                          setState(() {
                            genreList.add(genres[i]);
                          });
                        }

                        // Ligando ou desligando busca por genero
                        if (genreList.isNotEmpty) {
                          setState(() {
                            isGenreSearchSelected = true;
                          });
                        } else {
                          isGenreSearchSelected = false;
                        }
                      },
                    ),
                  ),
                  // Cria a linha divisora entre as opções
                ]
              ],
            ),
          ),
        ),
        // Drawer do scaffold
        drawer: const DrawerForPages(),
        // Body do scaffold
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
                          List<int> listOfElements = [];
                          List<int> listWithPositionOfSearchItens = [];

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

                          if (isGenreSearchSelected == true &&
                              isNameSearchSelected == true) {
                            for (int i = 0;
                                i < snapshoot2.data!.docs.length;
                                i++) {
                              // Checa nome e generos
                              List<int> ListForCheckAllGenres = [];
                              for (int j = 0; j < genreList.length; j++) {
                                if (!listOfElements.contains(i) &&
                                    snapshoot2.data!.docs
                                        .elementAt(i)
                                        .get("Generos")
                                        .contains(genreList[j]) &&
                                    indexObra.contains(i)) {
                                  ListForCheckAllGenres.add(j);
                                }
                                if (ListForCheckAllGenres.length ==
                                        genreList.length &&
                                    snapshoot2.data!.docs
                                        .elementAt(i)
                                        .get("Nome")
                                        .toString()
                                        .toLowerCase()
                                        .contains(
                                            _NameForSearch.toLowerCase()) &&
                                    indexObra.contains(i)) {
                                  listOfElements.add(i);
                                }
                              }
                            }
                          } else if (isNameSearchSelected == true) {
                            // TODO mudar para receber nome a partir de textcontroller
                            for (int i = 0;
                                i < snapshoot2.data!.docs.length;
                                i++) {
                              if (snapshoot2.data!.docs
                                      .elementAt(i)
                                      .get("Nome")
                                      .toString()
                                      .toLowerCase()
                                      .contains(_NameForSearch.toLowerCase()) &&
                                  indexObra.contains(i)) {
                                listOfElements.add(i);
                              }
                            }
                          } else if (isGenreSearchSelected == true) {
                            for (int i = 0;
                                i < snapshoot2.data!.docs.length;
                                i++) {
                              List<int> ListForCheckAllGenres = [];
                              // TODO mudar para receber 1 genero a partir de uma variavel não constante
                              for (int j = 0; j < genreList.length; j++) {
                                if (!listOfElements.contains(i) &&
                                    snapshoot2.data!.docs
                                        .elementAt(i)
                                        .get("Generos")
                                        .contains(genreList[j]) &&
                                    indexObra.contains(i)) {
                                  ListForCheckAllGenres.add(j);
                                }
                                if (ListForCheckAllGenres.length ==
                                        genreList.length &&
                                    indexObra.contains(i)) {
                                  listOfElements.add(i);
                                }
                              }
                            }
                          }

                          for (int i = 0; i < listOfElements.length; i++) {
                            for (int j = 0; j < indexObra.length; j++) {
                              if (listOfElements[i] == indexObra[j]) {
                                listWithPositionOfSearchItens.add(j);
                              }
                            }
                          }

                          print("Index Obra $indexObra");
                          print("Lista elementos $listOfElements");
                          print(
                              "Lista da posição dos itens $listWithPositionOfSearchItens");

                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.49,
                            ),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: isGenreSearchSelected == false &&
                                    isNameSearchSelected == false
                                ? snapshoot.data!.docs[indexUser]
                                    .get('$tipoPagina favoritos')
                                    .length
                                : listOfElements.length,
                            itemBuilder: (context, index) {
                              // Variavel de index para selecionar as obras na snapshoot
                              int customIndex;

                              print("index $index");
                              print("indexObra[index] ${indexObra[index]}");

                              // Definindo a variavel de index i para todas as obras do banco de dados
                              if (isGenreSearchSelected == false &&
                                  isNameSearchSelected == false) {
                                customIndex = indexObra[index];
                              }
                              // Definindo a variavel de index i para as obras do banco de dados que correspondem aos filtros de nome ou genero
                              else {
                                customIndex = listOfElements[index];
                              }

                              return Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(
                                        mediaquery.size.width * 0.022),
                                    child: GestureDetector(
                                      onTap: tipoPagina == "Animes"
                                          ? () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AnimeScreen(
                                                        snapshot: snapshoot2
                                                            .data!.docs
                                                            .elementAt(
                                                                customIndex),
                                                      )))
                                          : () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MangaScreen(
                                                          snapshot: snapshoot2
                                                              .data!.docs
                                                              .elementAt(
                                                                  customIndex)))),
                                      child: GridTile(
                                        child: Column(
                                          children: <Widget>[
                                            SizedBox(
                                              height:
                                                  mediaquery.size.height * 0.19,
                                              width:
                                                  mediaquery.size.width * 0.3,
                                              child: Image.network(
                                                snapshoot2.data!.docs
                                                    .elementAt(customIndex)
                                                    .get("Url capa"),
                                                fit: BoxFit.fill,
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
                                                  .elementAt(customIndex)
                                                  .get("Nome"),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                            ),
                                            // Mostra o episodio/capitulo atual do usuario
                                            PopupMenuButton(
                                              itemBuilder: (context) => [
                                                for (int i = 1;
                                                    i <=
                                                        snapshoot2.data!.docs
                                                            .elementAt(
                                                                customIndex)
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
                                                                      '$tipoPagina favoritos')[isNameSearchSelected ==
                                                                          false &&
                                                                      isGenreSearchSelected ==
                                                                          false
                                                                  ? index
                                                                  : listWithPositionOfSearchItens[
                                                                      index]]["Id"],
                                                              "$obraEpisodioOuCapitulo Atual": snapshoot
                                                                  .data!
                                                                  .docs[
                                                                      indexUser]
                                                                  .get(
                                                                      '$tipoPagina favoritos')[isNameSearchSelected ==
                                                                          false &&
                                                                      isGenreSearchSelected ==
                                                                          false
                                                                  ? index
                                                                  : listWithPositionOfSearchItens[
                                                                      index]]["$obraEpisodioOuCapitulo Atual"]
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
                                                                      '$tipoPagina favoritos')[isNameSearchSelected ==
                                                                          false &&
                                                                      isGenreSearchSelected ==
                                                                          false
                                                                  ? index
                                                                  : listWithPositionOfSearchItens[
                                                                      index]]["Id"],
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
                                                    '$obraEpisodioOuCapitulo ${snapshoot.data!.docs[indexUser].get('$tipoPagina favoritos')[isNameSearchSelected == false && isGenreSearchSelected == false ? index : listWithPositionOfSearchItens[index]]["$obraEpisodioOuCapitulo Atual"]}',
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
                                              decoration: BoxDecoration(
                                                color: colorForMarcation(snapshoot2
                                                    .data!.docs
                                                    .elementAt(customIndex)
                                                    .get(
                                                        "Data Ultimo $obraEpisodioOuCapitulo")),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              height:
                                                  mediaquery.size.height * 0.03,
                                              width:
                                                  mediaquery.size.width * 0.3,
                                              child: Center(
                                                child: Text(
                                                  snapshoot2.data!.docs
                                                      .elementAt(customIndex)
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
