import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:otakusukejuru/components/color_of_marcation.dart';

class MangaScreen extends StatefulWidget {
  const MangaScreen({super.key, required this.snapshot});
  final QueryDocumentSnapshot<Object?> snapshot;
  @override
  State<MangaScreen> createState() => _MangaScreenState(snapshot);
}

class _MangaScreenState extends State<MangaScreen> {
  // Nome que sera apresentado na APPBAR
  static const String pageName = 'Pagina de manga';
  final QueryDocumentSnapshot<Object?> snapshot;
  String generos = "";

  // Construtor da classe
  _MangaScreenState(this.snapshot);

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < snapshot.get("Generos").length; i++) {
      generos = "$generos ${snapshot.get("Generos")[i]}";
      if (snapshot.get("Generos").length - 1 > i) {
        generos = "$generos            ";
      }
    }
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
              onTap: () async {
                // pega o documento do usuario do firebase
                final stor = await FirebaseFirestore.instance
                    .collection("Users")
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .get();

                // Cria uma lista de strings chama "a"
                List<String> listIdsAnimes = [];

                // Percorre o array chamado de animes favoritos e adiciona os ids de cada anime favoritado a lista "listIdsAnimes"
                for (int i = 0;
                    i < stor.data()!['Mangas favoritos'].length;
                    i++) {
                  listIdsAnimes.add(stor.data()!['Mangas favoritos'][i]["Id"]);
                }

                // caso o anime ja esteja favoritado ele sera removido, se não ele sera adicionado a lista de favoritos
                if (listIdsAnimes.contains(snapshot.id)) {
                  final list = stor["Mangas favoritos"] as List;

                  int indexForRemotion = 0;

                  // Varre o list atras do item com id igual ao snapshot.id
                  for (int i = 0;
                      i < stor.data()!['Mangas favoritos'].length;
                      i++) {
                    if (list[i]["Id"] == snapshot.id) {
                      indexForRemotion = i;
                    }
                  }
                  // remove item que ja esta favoritado
                  list.removeAt(indexForRemotion);

                  // remove o array antigo pelo novo sem o item
                  await FirebaseFirestore.instance
                      .collection('Users')
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .update({"Mangas favoritos": list});
                } else {
                  // adiciona o novo map com o anime favoritado na lista de Mangas favoritos
                  await FirebaseFirestore.instance
                      .collection("Users")
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .update({
                    "Mangas favoritos": FieldValue.arrayUnion([
                      {"Id": snapshot.id.toString(), "Capitulo Atual": 1}
                    ])
                  });
                }
              },
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("Users")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshoot) {
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
                        var indexObra;

                        // Pega index do usuario atual
                        for (int i = 0; i < snapshoot.data!.size; i++) {
                          if (snapshoot.data!.docs[i].id ==
                              FirebaseAuth.instance.currentUser?.uid) {
                            indexUser = i;
                          }
                        }

                        // Pega index do anime atual
                        for (int i = 0;
                            i <
                                snapshoot.data!.docs[indexUser]
                                    .get('Mangas favoritos')
                                    .length;
                            i++) {
                          if (snapshoot.data!.docs[indexUser]
                                  .get('Mangas favoritos')[i]["Id"] ==
                              snapshot.id) {
                            indexObra = i;
                          }
                        }

                        // Retorna o icone de favoritos preenchido se indexObra existir (se existir significar que a obra esta nos favoritos), e retorna o icone
                        // de favoritos não preenchido caso
                        if (indexObra == null) {
                          return const Icon(Icons.favorite_border);
                        }
                        return const Icon(Icons.favorite);
                    }
                  }),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        // Body do scaffold TODO criar
        body: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(mediaquery.size.width * 0.05),
                  child: SizedBox(
                    width: mediaquery.size.width * 0.45,
                    height: mediaquery.size.height * 0.33,
                    child: Image.network(
                      snapshot.get("Url capa"),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: mediaquery.size.width * 0.05,
                    right: mediaquery.size.width * 0.05,
                    bottom: mediaquery.size.width * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Autores',
                        style:
                            TextStyle(color: Color(0xFF7289DA), fontSize: 16),
                      ),
                      // Autores
                      SizedBox(
                        width: mediaquery.size.width * 0.36,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0;
                                i < snapshot.get("Autores").length && i < 4;
                                i++) ...[
                              Text(
                                snapshot.get("Autores")[i],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ],
                        ),
                      ),
                      // Espaço entre topicos
                      SizedBox(height: mediaquery.size.width * 0.04),
                      const Text(
                        'Serialização',
                        style:
                            TextStyle(color: Color(0xFF7289DA), fontSize: 16),
                      ),
                      // Serialização
                      SizedBox(
                        width: mediaquery.size.width * 0.36,
                        child: Text(
                          snapshot.get("Serializacao"),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                      // Espaço entre topicos
                      SizedBox(height: mediaquery.size.width * 0.04),
                      const Text(
                        'Publicado em',
                        style:
                            TextStyle(color: Color(0xFF7289DA), fontSize: 16),
                      ),
                      // TODO puxar Studio do snapshot
                      SizedBox(
                        width: mediaquery.size.width * 0.36,
                        child: Text(
                          "${snapshot.get("Inicio de publicacao")} ate ${snapshot.get("Fim de publicacao")}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            // Rows com outros topicos
            Text(
              snapshot.get("Nome"),
              style: const TextStyle(color: Colors.white, fontSize: 28),
            ),
            // Espaço entre topicos
            SizedBox(height: mediaquery.size.width * 0.05),
            // Generos
            Center(
              child: Text(
                generos,
                style: const TextStyle(color: Color(0xFF7289DA), fontSize: 16),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Espaço entre topicos
            SizedBox(height: mediaquery.size.width * 0.05),
            // Ep atual com caixa com padrão de cores
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color:
                        colorForMarcation(snapshot.get("Data Ultimo Capitulo")),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  height: mediaquery.size.height * 0.045,
                  width: mediaquery.size.width * 0.4,
                  child: Center(
                    child: Text(
                      snapshot.get("Ultimo Capitulo").toString(),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            // Espaço entre topicos
            SizedBox(height: mediaquery.size.width * 0.05),
            // Sinopse
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Sinopse",
                  style: TextStyle(color: Colors.white, fontSize: 26),
                ),
              ],
            ),
            SizedBox(
              height: mediaquery.size.height * 0.18,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: mediaquery.size.width * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      snapshot.get("Sinopse").toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.start,
                      maxLines: 7,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            // Espaço entre topicos
            SizedBox(height: mediaquery.size.width * 0.05),
            // Botões para redirecionar a sites oficiais
            // TODO falta adicionar nomes dos sites que seram redirecionados no botões, e função para redirecionar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: SizedBox(
                      width: mediaquery.size.width * 0.35,
                      height: mediaquery.size.height * 0.05,
                    ),
                  ),
                ),
                SizedBox(
                  width: mediaquery.size.width * 0.1,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: SizedBox(
                      width: mediaquery.size.width * 0.35,
                      height: mediaquery.size.height * 0.05,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
