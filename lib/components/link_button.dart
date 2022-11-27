import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LinkButton extends StatelessWidget {
  final String animeOrManga;
  final int numberOfLinks;
  final QueryDocumentSnapshot<Object?> snapshot;

  const LinkButton({
    super.key,
    required this.numberOfLinks,
    required this.snapshot,
    required this.animeOrManga,
  });

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);

    if (numberOfLinks == 2) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              final url = snapshot.get("Link acesso 1");
              if (await canLaunchUrlString(url)) {
                await launchUrlString(url,
                    mode: LaunchMode.externalApplication);
              } else {
                throw 'Could not launch $url';
              }
            },
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (animeOrManga == "Anime") ...[
                      const Text(
                        "Crunchyroll",
                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ] else if (animeOrManga == "Manga") ...[
                      const Text(
                        "Não sei qual o site ainda",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: mediaquery.size.width * 0.1),
          GestureDetector(
            onTap: () async {
              final url = snapshot.get("Link acesso 2");
              if (await canLaunchUrlString(url)) {
                await launchUrlString(url,
                    mode: LaunchMode.externalApplication);
              } else {
                throw 'Could not launch $url';
              }
            },
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (animeOrManga == "Anime") ...[
                      const Text(
                        "Netflix",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ] else if (animeOrManga == "Manga") ...[
                      const Text(
                        "Webtoon",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          )
        ],
      );
    } else if (numberOfLinks == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              if (snapshot.get("Link acesso 2").toString().isEmpty) {
                final url = snapshot.get("Link acesso 1");
                if (await canLaunchUrlString(url)) {
                  await launchUrlString(url,
                      mode: LaunchMode.externalApplication);
                } else {
                  throw 'Could not launch $url';
                }
              } else {
                final url = snapshot.get("Link acesso 2");
                if (await canLaunchUrlString(url)) {
                  await launchUrlString(url,
                      mode: LaunchMode.externalApplication);
                } else {
                  throw 'Could not launch $url';
                }
              }
            },
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (animeOrManga == "Anime") ...[
                      if (snapshot.get("Link acesso 2").toString().isEmpty) ...[
                        const Text(
                          "Crunchyroll",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ] else ...[
                        const Text(
                          "Netflix",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]
                    ],
                    if (animeOrManga == "Manga") ...[
                      if (snapshot.get("Link acesso 2").toString().isEmpty) ...[
                        const Text(
                          "Não sei qual o site ainda",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ] else ...[
                        const Text(
                          "Webtoon",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    } else if (numberOfLinks == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Infelizmente não existem sites oficiais com acesso a obra.",
              style: TextStyle(color: Colors.white, fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
    }

    return Container();
  }
}
