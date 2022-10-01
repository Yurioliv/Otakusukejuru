import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otakusukejuru/components/sign_textfields.dart';

class LostUsernameScreen extends StatefulWidget {
  const LostUsernameScreen({super.key});

  @override
  State<LostUsernameScreen> createState() => _LostUsernameScreenState();
}

class _LostUsernameScreenState extends State<LostUsernameScreen> {
  //controladores para os textfields
  final _emailController = TextEditingController();
  var _emailName;

  @override
  void initState() {
    super.initState();

    _emailController.addListener((_updateEmail));
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _updateEmail() {
    setState(() {
      _emailName = _emailController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Força esta tela a estar na vertical. Pode não funcionar em alguns dispositivos IOS.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(0xff23272A),
        body: Stack(
          children: <Widget>[
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(
                  top: 100.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // Para mexer os widgets dentro do children horizontalmente dar wrap no widget com uma "Row", Dentro da "Row" vai ser criado um children, dentro dele voce pode criar
                  // uma SizedBox e definir o tamanho de width para dar criar um espaço horizontalmente, e o tamanho de height.
                  children: <Widget>[
                    //Nome do programa no topo da tela.
                    const Text(
                      'Otakusukejuru',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'OpenSans',
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    //Texto de explicação para recuperar senha
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                          'Por favor informe o email registrado a sua conta abaixo. Você recebera uma mensagem por email informando o seu nome de usuário em breve.',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.justify),
                    ),
                    const SizedBox(height: 80.0),
                    //TextFields para que o usuario digite os dados a serem cadastrados.
                    EmailTextField(
                        texto: "Email", controlador: _emailController),
                    const SizedBox(height: 60.0),
                    //Botão para enviar pedido de recuperação de nome de usuario para o banco de dados.
                    TextButton(
                      onPressed:
                          null, //TODO colocar função para comunicar com o banco de dados e fazer pedido de recuperação de nome de usuario.
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(280, 50),
                      ),
                      child: const Text(
                        'Recuperar nome de usuário',
                        style: TextStyle(
                          color: Color(0xFF2C2F33),
                          fontFamily: 'OpenSans',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 180.0),
                    //Botão para voltar a tela anterior.
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        minimumSize: const Size(110, 50),
                        maximumSize: const Size(110, 50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24.0,
                          ),
                          Text(
                            'Voltar',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //SizedBox para dar espaço para o scrollview no caso de o dispositivos ser pequeno verticalmente.
                    const SizedBox(height: 40.0),
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