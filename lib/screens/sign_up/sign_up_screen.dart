import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otakusukejuru/components/sign_textfields.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //controladores para os textfields
  final _emailController = TextEditingController();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cPasswordController = TextEditingController();
  var _emailName;
  var _userName;
  var _passwordName;
  var _cPasswordName;

  @override
  void initState() {
    super.initState();

    _emailController.addListener((_updateEmail));
    _userController.addListener((_updateUser));
    _passwordController.addListener((_updatePassword));
    _cPasswordController.addListener((_updatecPassword));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _userController.dispose();
    _passwordController.dispose();
    _cPasswordController.dispose();
    super.dispose;
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

  void _updateEmail() {
    setState(() {
      _emailName = _emailController.text;
    });
  }

  void _updatecPassword() {
    setState(() {
      _cPasswordName = _cPasswordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Força esta tela a estar na vertical. Pode não funcionar em alguns dispositivos IOS.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
                  //Botão para logar com o google.
                  TextButton(
                    onPressed:
                        null, //TODO colocar função para acesso/cadastro pelo google.
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
                  const SizedBox(height: 30.0),
                  //Linha divisora.
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60.0),
                    child: Divider(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  //Texto "insira as informações a baixo" entre o divisor e os textfields na tela.
                  const Text(
                    'Insira as informações a baixo',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  //TextFields para que o usuario digite os dados a serem cadastrados.
                  loginTextField("Email", _emailController),
                  const SizedBox(height: 10.0),
                  loginTextField("Usuário", _userController),
                  const SizedBox(height: 10.0),
                  passwordTextField("Senha", _passwordController),
                  const SizedBox(height: 10.0),
                  passwordTextField("Confirmar Senha", _cPasswordController),
                  const SizedBox(height: 60.0),
                  //Botão para fazer o cadastro com os dados.
                  TextButton(
                    onPressed:
                        null, //TODO colocar função para comunicar com o banco de dados e fazer cadastro.
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
                  //SizedBox para dar espaço para o scrollview no caso de o dispositivos ser pequeno verticalmente.
                  const SizedBox(height: 60.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
