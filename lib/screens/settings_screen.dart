import 'package:flutter/material.dart';
import 'package:otakusukejuru/components/drawer_for_pages.dart';
import 'package:otakusukejuru/screens/change_username_screen.dart';
import 'package:otakusukejuru/screens/help_screen.dart';
import 'package:otakusukejuru/screens/lost_password_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Nome que sera apresentado na APPBAR
  static const String pageName = 'Configurações';

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
        ),
        // Drawer do scaffold
        drawer: const DrawerForPages(),
        // Body do scaffold
        body: Stack(
          children: <Widget>[
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                // Verificar se realmente farei a configuração de mudança de tema
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // ListTile para mudar tema
                    SizedBox(height: mediaquery.size.height * 0.011),
                    // ListTile(
                    //   title: const Text(
                    //     'Mudar tema',
                    //     style: TextStyle(color: Colors.white, fontSize: 20),
                    //   ),
                    //   onTap: () {},
                    // ),
                    // Cria a linha divisora entre as opções
                    // const Divider(
                    //   color: Color(0xff454545),
                    // ),
                    // ListTile para mudar nome de usuario
                    ListTile(
                      title: const Text(
                        'Mudar nome de usuário',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ChangeUserNameScreen()));
                      },
                    ),
                    // Cria a linha divisora entre as opções
                    const Divider(
                      color: Color(0xff454545),
                    ),
                    // ListTile para mudar senha
                    ListTile(
                      title: const Text(
                        'Mudar senha',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const LostPasswordScreen()));
                      },
                    ),
                    // Cria a linha divisora entre as opções
                    const Divider(
                      color: Color(0xff454545),
                    ),
                    // ListTile para ir para ir a tela de ajuda
                    ListTile(
                      title: const Text(
                        'Ajuda',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HelpScreen()));
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
