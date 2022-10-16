import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otakusukejuru/screens/help_screen.dart';

class CoresEstadoScreen extends StatefulWidget {
  const CoresEstadoScreen({super.key});

  @override
  State<CoresEstadoScreen> createState() => _CoresEstadoScreenState();
}

class _CoresEstadoScreenState extends State<CoresEstadoScreen> {
  // Nome que sera apresentado na APPBAR
  static const String pageName = 'Cores e estados das obras';

  @override
  Widget build(BuildContext context) {
    //Força esta tela a estar na vertical. Pode não funcionar em alguns dispositivos IOS.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // Textos na tela
                      const SizedBox(height: 8),
                      const Text(
                        'São usadas 3 cores para representar o estado do manga/anime:',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      const SizedBox(height: 28),
                      // RichText com texto em vermelho
                      RichText(
                        text: const TextSpan(
                          text: 'Vermelho:',
                          style: TextStyle(color: Colors.red, fontSize: 20),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  ' Significa que o capítulo/episódio mostrado foi lançado a menos de 7 dias.',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      // RichText com texto em azul
                      RichText(
                        text: const TextSpan(
                          text: 'Azul:',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  ' Significa que o capítulo/episódio mostrado foi o ultimo lançado e ja se passaram mais de 7 dias.',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      // RichText com texto em cinza
                      RichText(
                        text: const TextSpan(
                          text: 'Cinza  :',
                          style:
                              TextStyle(color: Colors.blueGrey, fontSize: 20),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  ' Significa que o capítulo/episódio mostrado foi o ultimo lançado e ja se passaram mais de 7 dias.',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
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
