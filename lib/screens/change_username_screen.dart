import 'package:flutter/material.dart';
import 'package:otakusukejuru/components/sign_textfields.dart';
import 'package:otakusukejuru/services/auth_service.dart';

class ChangeUserNameScreen extends StatefulWidget {
  const ChangeUserNameScreen({super.key});

  @override
  State<ChangeUserNameScreen> createState() => ChangeUserNameScreenState();
}

class ChangeUserNameScreenState extends State<ChangeUserNameScreen> {
  //controladores para os textfields
  final _userNameController = TextEditingController();
  String _userName = '';

  @override
  void initState() {
    super.initState();

    _userNameController.addListener((_updateUserName));
  }

  @override
  void dispose() {
    _userNameController.dispose();
    super.dispose();
  }

  void _updateUserName() {
    setState(() {
      _userName = _userNameController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    //Texto de explicação para mudar usuario
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                          'Por favor informe o seu novo nome de usuário abaixo.',
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
                    UserTextField(
                        texto: "Nome de usuário",
                        controlador: _userNameController),
                    const SizedBox(height: 60.0),
                    //Botão para enviar pedido de recuperação de senha para o banco de dados.
                    TextButton(
                      onPressed: () {
                        if (_userName.isEmpty) {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text(
                                        'Campo nome de usuário vazio'),
                                    content: const Text(
                                        'O campo nome de usuário não pode estar vazio, por favor escreva o seu novo nome de usuário'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Ok'),
                                      ),
                                    ],
                                  ));
                        } else {
                          AuthService().changeUserName(userName: _userName);
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => WillPopScope(
                              onWillPop: () => Future.value(false),
                              child: AlertDialog(
                                title: const Text('Nome de usuário mudado.'),
                                content: const Text(
                                    'Quando voltar ao menu seu nome de usuário ja estara mudado.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => {
                                      Navigator.pop(context),
                                      Navigator.pop(context),
                                    },
                                    child: const Text('Ok'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(200, 50),
                      ),
                      child: const Text(
                        'Mudar nome de usuário',
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
