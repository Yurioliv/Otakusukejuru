import 'package:cloud_firestore/cloud_firestore.dart';
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
              onTap: () {},
              child: const Icon(Icons.favorite_border),
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
