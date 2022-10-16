import 'package:flutter/material.dart';
import 'package:otakusukejuru/components/image_user.dart';
import 'package:otakusukejuru/main.dart';
import 'package:otakusukejuru/screens/exploration_screen.dart';
import 'package:otakusukejuru/screens/favorites_screen.dart';
import 'package:otakusukejuru/screens/settings_screen.dart';
import 'package:otakusukejuru/services/auth_service.dart';

class DrawerForPages extends StatelessWidget {
  const DrawerForPages({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Container(
        color: const Color(0xff23272A),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            // Mostra imagem de usuario
            const ImageUser(),
            const SizedBox(
              height: 30,
            ),
            // Mostra o nome do usuario/nickname
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                AuthService().userName!,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // Cria a linha divisora entre as opções
            const Divider(
              color: Color(0xff454545),
            ),
            // ListTile Favoritos
            ListTile(
              leading: const Icon(Icons.star, size: 32, color: Colors.white),
              title: const Text(
                'Favoritos',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavoriteScreen()));
              },
            ),
            // Cria a linha divisora entre as opções
            const Divider(
              color: Color(0xff454545),
            ),
            // ListTile Explorar
            ListTile(
              leading:
                  const Icon(Icons.more_horiz, size: 32, color: Colors.white),
              title: const Text(
                'Explorar',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ExplorationScreen()));
              },
            ),
            // Cria a linha divisora entre as opções
            const Divider(
              color: Color(0xff454545),
            ),
            // ListTile Configurações
            ListTile(
              leading:
                  const Icon(Icons.settings, size: 32, color: Colors.white),
              title: const Text(
                'Configurações',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsScreen()));
              },
            ),
            // Cria a linha divisora entre as opções
            const Divider(
              color: Color(0xff454545),
            ),
            // ListTile Sair
            ListTile(
              leading:
                  const Icon(Icons.exit_to_app, size: 32, color: Colors.white),
              title: const Text(
                'Sair',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                AuthService().signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const MyApp()));
              },
            ),
            // Cria a linha divisora entre as opções
            const Divider(
              color: Color(0xff454545),
            ),
          ],
        ),
      ),
    );
  }
}
