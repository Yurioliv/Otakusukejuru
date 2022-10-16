import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otakusukejuru/screens/Cores_estado_screen.dart';
import 'package:otakusukejuru/screens/links_direitos_autorais_screen.dart';
import 'package:otakusukejuru/screens/objetivo_aplicativo_screen.dart';
import 'package:otakusukejuru/screens/settings_screen.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  // Nome que sera apresentado na APPBAR
  static const String pageName = 'Ajuda';

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
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsScreen()));
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
                // TODO criar lista de animes em um grid abaixo
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // ListTile para mudar tema
                    const SizedBox(height: 8),
                    ListTile(
                      title: const Text(
                        'Cores e estado das obras',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CoresEstadoScreen()));
                      },
                    ),

                    // Cria a linha divisora entre as opções
                    const Divider(
                      color: Color(0xff454545),
                    ),
                    // ListTile para mudar nome de usuario
                    ListTile(
                      title: const Text(
                        'Objetivo do aplicativo',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ObjetivoAplicativoScreen()));
                      },
                    ),
                    // Cria a linha divisora entre as opções
                    const Divider(
                      color: Color(0xff454545),
                    ),
                    // ListTile para mudar senha
                    ListTile(
                      title: const Text(
                        'Links e Direitos autorais',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const LinksDireitosAutoriasScreen()));
                      },
                    ),
                    // Cria a linha divisora entre as opções
                    const Divider(
                      color: Color(0xff454545),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
