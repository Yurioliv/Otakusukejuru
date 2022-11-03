import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:otakusukejuru/components/sign_textfields.dart';
import 'package:otakusukejuru/services/auth_service.dart';

class LostPasswordScreen extends StatefulWidget {
  const LostPasswordScreen({super.key});

  @override
  State<LostPasswordScreen> createState() => _LostPasswordScreenState();
}

class _LostPasswordScreenState extends State<LostPasswordScreen> {
  //controladores para os textfields
  final _emailController = TextEditingController();
  String _emailName = '';

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
    final mediaquery = MediaQuery.of(context);
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
                padding: EdgeInsets.only(
                  top: mediaquery.size.height * 0.13,
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
                    SizedBox(height: mediaquery.size.height * 0.05),
                    //Texto de explicação para recuperar senha
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: mediaquery.size.width * 0.1),
                      child: const Text(
                          'Por favor informe o email registrado a sua conta abaixo. Você recebera uma mensagem por email informando como fazer a troca para uma nova senha.',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.justify),
                    ),
                    SizedBox(height: mediaquery.size.height * 0.1),
                    //TextFields para que o usuario digite os dados a serem cadastrados.
                    EmailTextField(
                        texto: "Email", controlador: _emailController),
                    SizedBox(height: mediaquery.size.height * 0.08),
                    //Botão para enviar pedido de recuperação de senha para o banco de dados.
                    TextButton(
                      onPressed: () {
                        if (_emailName.isEmpty) {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('Campo email vazio'),
                                    content: const Text(
                                        'O campo email não pode estar vazio, por favor escreva o seu email ja cadastrado, se não tiver se cadastrado ainda clique no botão Criar Conta.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Ok'),
                                      ),
                                    ],
                                  ));
                        } else if (!EmailValidator.validate(_emailName)) {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('Insira um email valido'),
                                    content: const Text(
                                        'O email digitado é invalido, verifique se digitou o email corretamente.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Ok'),
                                      ),
                                    ],
                                  ));
                        } else {
                          AuthService()
                              .changeUserPassword(userEmail: _emailName);
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) => WillPopScope(
                              onWillPop: () => Future.value(false),
                              child: AlertDialog(
                                title: const Text(
                                    'Mensagem para troca de senha enviada'),
                                content: const Text(
                                    'Por favor acesse seu email e clique no link disponibilizado para trocar sua conta.'),
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
                        minimumSize: Size(
                          mediaquery.size.width * 0.55,
                          mediaquery.size.height * 0.065,
                        ),
                      ),
                      child: const Text(
                        'Recuperar senha',
                        style: TextStyle(
                          color: Color(0xFF2C2F33),
                          fontFamily: 'OpenSans',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: mediaquery.size.height * 0.15),
                    //Botão para voltar a tela anterior.
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        minimumSize: Size(
                          mediaquery.size.width * 0.35,
                          mediaquery.size.height * 0.065,
                        ),
                        maximumSize: Size(
                          mediaquery.size.width * 0.35,
                          mediaquery.size.height * 0.065,
                        ),
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
                    SizedBox(height: mediaquery.size.height * 0.01),
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
