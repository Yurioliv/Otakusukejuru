import 'package:flutter/material.dart';
import 'package:otakusukejuru/screens/sign_in/components/sign_in_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  var _userName;
  var _passwordName;

  @override
  void initState() {
    super.initState();

    _userController.addListener((_updateUser));
    _passwordController.addListener((_updatePassword));
  }

  void _updateUser() {
    setState(() {
      _userName = _userController.text;
    });
  }

  void _updatePassword() {
    setState(() {
      _passwordName = _passwordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xff23272A),
            ),
          ),
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
                  const SizedBox(height: 60.0),
                  //Teste para ver se os controllers estão funcionando
                  Text(
                    'user: ${_userController.text}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'senha: ${_passwordController.text}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  //Botão para logar com o google
                  TextButton(
                    onPressed:
                        null, //TODO colocar função para acesso pelo google.
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(250, 50),
                    ),
                    child: const Text(
                      'Logar com google',
                      style: TextStyle(
                        color: Color(0xFF2C2F33),
                        fontFamily: 'OpenSans',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 90.0),
                  //Nome 'Usuário' pequeno em cima do campo de texto.
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 40.0),
                        child: Text(
                          'Usuário:',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  //Campo de texto que deve receber o nome de usuario e verificar se ele condiz com algum nome no banco de dados para permitir o login do usuario.
                  loginTextField("Nome de usuário", _userController),
                  //Botão que leva a tela para recuperar o nome de usuario por email
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: const TextButton(
                          onPressed:
                              null, //TODO colocar função que leva para tela de esqueceu o nome de usuario
                          child: Text(
                            'Esqueceu seu nome de usuário?',
                            style: TextStyle(color: Color(0xFF7289DA)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Nome 'Senha' pequeno em cima do campo de texto.
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 40.0),
                        child: Text(
                          'Senha:',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  //Campo de texto que deve receber a senha e verificar se ele condiz com a senhha para o usuário no banco de dados para permitir o login do usuario.
                  loginTextField("Senha", _passwordController),
                  //Botão que leva a tela para recuperar a senha por email
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 40.0),
                        child: const TextButton(
                          onPressed:
                              null, //TODO colocar função que leva para tela de esqueceu a senha
                          child: Text(
                            'Esqueceu sua senha?',
                            style: TextStyle(color: Color(0xFF7289DA)),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  //Botão para fazer login, ele deve comparar os dados com o banco de dados, se forem correspondentes deve autenticar o usuario.
                  TextButton(
                    onPressed:
                        null, //TODO colocar função para autenticar usuario.
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(120, 50),
                    ),
                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        color: Color(0xFF2C2F33),
                        fontFamily: 'OpenSans',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  //Texto no final da tela, "Ainda não tem conta?"
                  const Text(
                    'Ainda não tem conta?',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  //Botão para fazer login, ele deve comparar os dados com o banco de dados, se forem correspondentes deve autenticar o usuario.
                  TextButton(
                    onPressed:
                        null, //TODO colocar função para enviar para tela de cadastro.
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: const Size(150, 50),
                    ),
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(
                        color: Color(0xFF2C2F33),
                        fontFamily: 'OpenSans',
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
