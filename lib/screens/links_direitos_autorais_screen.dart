import 'package:flutter/material.dart';
import 'package:otakusukejuru/screens/help_screen.dart';

class LinksDireitosAutoriasScreen extends StatefulWidget {
  const LinksDireitosAutoriasScreen({super.key});

  @override
  State<LinksDireitosAutoriasScreen> createState() =>
      _LinksDireitosAutoriasScreenState();
}

class _LinksDireitosAutoriasScreenState
    extends State<LinksDireitosAutoriasScreen> {
  // Nome que sera apresentado na APPBAR
  static const String pageName = 'Links e direitos autorais';

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
                        'Esse aplicativo respeita as leis de direitos autorais brasileiras como visto na Lei nº 9.610/98, todos os direitos autorais são atribuidos aos devidos criadores e divulgadores do conteudo. Todo e qualquer link para fora do aplicativo leva a partes publicas de sites privados os quais possuem os devidos direitos autorais sobre o conteúdo, o que os permite divulga-los, este aplicativo não distribui o devido conteudo, apenas notifica os usuarios do aplicativo sobre o lançamento de novos capítulos e episódios, alem de oferecer um sistema para que eles marquem os ultimos capítulos e episódios vistos.',
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
