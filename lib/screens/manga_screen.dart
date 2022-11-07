import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  _MangaScreenState(this.snapshot);

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
                      // TODO puxar fonte do snapshot
                      SizedBox(
                        width: mediaquery.size.width * 0.36,
                        child: Text(
                          'Asd',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                      // Espaço entre topicos
                      SizedBox(
                        height: mediaquery.size.width * 0.05,
                      ),
                      const Text(
                        'Serialização',
                        style:
                            TextStyle(color: Color(0xFF7289DA), fontSize: 16),
                      ),
                      // TODO puxar Temporada do snapshot
                      SizedBox(
                        width: mediaquery.size.width * 0.36,
                        child: Text(
                          'Asd',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                      // Espaço entre topicos
                      SizedBox(
                        height: mediaquery.size.width * 0.05,
                      ),
                      const Text(
                        'Publicado em',
                        style:
                            TextStyle(color: Color(0xFF7289DA), fontSize: 16),
                      ),
                      // TODO puxar Studio do snapshot
                      SizedBox(
                        width: mediaquery.size.width * 0.36,
                        child: Text(
                          'asdasdasdasdasdasdasdasda',
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
          ],
        ),
      ),
    );
  }
}
