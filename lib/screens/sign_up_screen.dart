import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otakusukejuru/components/sign_textfields.dart';
import 'package:otakusukejuru/services/auth_service.dart';

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
  String _emailName = '';
  String _userName = '';
  String _passwordName = '';
  String _cPasswordName = '';

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
    super.dispose();
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);

        return true;
      },
      child: GestureDetector(
        onTap: () {
          //FocusScope.of(context).requestFocus(FocusNode());
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
                      //Linha divisora.
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 60.0),
                        child: Divider(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 40.0),
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
                      EmailTextField(
                          texto: "Email", controlador: _emailController),
                      const SizedBox(height: 10.0),
                      UserTextField(
                          texto: "Nome de Usuário",
                          controlador: _userController),
                      const SizedBox(height: 10.0),
                      PasswordTextField(
                          texto: "Senha", controlador: _passwordController),
                      const SizedBox(height: 10.0),
                      PasswordTextField(
                          texto: "Confirmar Senha",
                          controlador: _cPasswordController),
                      const SizedBox(height: 60.0),
                      //Botão para fazer o cadastro com os dados.
                      TextButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          //Validações de dados para cadastro
                          if (_userName.isEmpty) {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text(
                                          'Campo nome de usuário vazio'),
                                      content: const Text(
                                          'O campo nome de usuário não pode estar vazio, por favor escreva um nome para o seu usuário.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Ok'),
                                        ),
                                      ],
                                    ));
                          } else if (_emailName.isEmpty) {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text('Campo email vazio'),
                                      content: const Text(
                                          'O campo email não pode estar vazio, por favor escreva um email para cadastro.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Ok'),
                                        ),
                                      ],
                                    ));
                          } else if (!EmailValidator.validate(_emailName)) {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => AlertDialog(
                                      title:
                                          const Text('Insira um email valido'),
                                      content: const Text(
                                          'O email digitado é invalido, verifique se digitou o email corretamente.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Ok'),
                                        ),
                                      ],
                                    ));
                          } else if (_passwordName.isEmpty) {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text('Campo senha vazio'),
                                      content: const Text(
                                          'O campo senha não pode estar vazio, por favor escreva uma senha.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Ok'),
                                        ),
                                      ],
                                    ));
                          } else if (_passwordName.length < 8) {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text(
                                          'Campo senha com menos de 8 caracteres'),
                                      content: const Text(
                                          'O campo senha não pode ter menos que 8 caracteres.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Ok'),
                                        ),
                                      ],
                                    ));
                          } else if (_cPasswordName.isEmpty) {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: const Text(
                                          'Campo confirmação de senha vazio'),
                                      content: const Text(
                                          'O campo confirmação de senha não pode estar vazio, por favor escreva a senha que você digitou no campo Senha acima.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Ok'),
                                        ),
                                      ],
                                    ));
                          } else if (_passwordName != _cPasswordName) {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text(
                                    'Senha e confirmação de senha são diferentes'),
                                content: const Text(
                                    'Tente reescrever as senhas e ter certeza de que elas são iguais.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Ok'),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            AuthService().signUpWithEmailAndPassword(
                                _emailName, _passwordName, _userName, context);
                          }
                        },
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
                      const SizedBox(height: 30.0),
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
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
