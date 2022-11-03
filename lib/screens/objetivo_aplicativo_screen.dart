import 'package:flutter/material.dart';
import 'package:otakusukejuru/screens/help_screen.dart';

class ObjetivoAplicativoScreen extends StatefulWidget {
  const ObjetivoAplicativoScreen({super.key});

  @override
  State<ObjetivoAplicativoScreen> createState() =>
      _ObjetivoAplicativoScreenState();
}

class _ObjetivoAplicativoScreenState extends State<ObjetivoAplicativoScreen> {
  // Nome que sera apresentado na APPBAR
  static const String pageName = 'Objetivo do aplicativo';

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
          leading: IconButton(
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HelpScreen()));
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text(
            pageName,
            style: TextStyle(fontSize: 24.0),
          ),
        ),
        // Body do scaffold
        body: Stack(
          children: <Widget>[
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                // Padding que para criar bordas para o texto não encostar na tela
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: mediaquery.size.height * 0.011,
                    horizontal: mediaquery.size.width * 0.042,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Textos na tela
                      SizedBox(height: mediaquery.size.height * 0.011),
                      const Text(
                        'Esse aplicativo tem o objetivo de ser um notificador e marcador para seus animes/mangas, de forma que você possa sempre se lembrar qual o ultimo capítulo/episódio o qual você viu e tambem ficar em dia com eles graças as notificações de lançamento criadas pelo aplicativo.',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(height: mediaquery.size.height * 0.05),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
