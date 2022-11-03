import 'dart:async';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:otakusukejuru/services/auth_service.dart';
import 'package:otakusukejuru/components/sign_textfields.dart';
import 'package:otakusukejuru/screens/lost_password_screen.dart';
import 'package:otakusukejuru/screens/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  //controladores para os textfields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _emailName = '';
  String _passwordName = '';
  late Timer timer;

  @override
  void initState() {
    super.initState();

    _emailController.addListener((_updateUser));
    _passwordController.addListener((_updatePassword));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateUser() {
    setState(() {
      _emailName = _emailController.text;
    });
  }

  void _updatePassword() {
    setState(() {
      _passwordName = _passwordController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    //Retorna a tela do programa em si.
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
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
                    //Botão para logar com o google
                    TextButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        AuthService().singInWithGoogle();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(
                          mediaquery.size.width * 0.6,
                          mediaquery.size.height * 0.065,
                        ),
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
                    SizedBox(height: mediaquery.size.height * 0.05),
                    //Nome 'Usuário' pequeno em cima do campo de texto.
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: mediaquery.size.width * 0.13),
                          child: const Text(
                            'Email:',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: mediaquery.size.height * 0.005),
                    //Campo de texto que deve receber o nome de usuario e verificar se ele condiz com algum nome no banco de dados para permitir o login do usuario.
                    EmailTextField(
                        texto: "Email", controlador: _emailController),
                    // Espaço entre textfields
                    SizedBox(
                      height: mediaquery.size.height * 0.04,
                    ),
                    //Nome 'Senha' pequeno em cima do campo de texto.
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: mediaquery.size.width * 0.13),
                          child: const Text(
                            'Senha:',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: mediaquery.size.height * 0.005),
                    //Campo de texto que deve receber a senha e verificar se ele condiz com a senhha para o usuário no banco de dados para permitir o login do usuario.
                    PasswordTextField(
                        texto: "Senha", controlador: _passwordController),
                    //Botão que leva a tela para recuperar a senha por email
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              right: mediaquery.size.width * 0.115),
                          child: TextButton(
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LostPasswordScreen()));
                            },
                            child: const Text(
                              'Esqueceu sua senha?',
                              style: TextStyle(color: Color(0xFF7289DA)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: mediaquery.size.height * 0.05),
                    //Botão para fazer login, ele deve comparar os dados com o banco de dados, se forem correspondentes deve autenticar o usuario.
                    TextButton(
                      onPressed: () {
                        //Validações de email e senha
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
                        } else if (_passwordName.isEmpty) {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('Campo senha vazio'),
                                    content: const Text(
                                        'O campo senha não pode estar vazio, por favor escreva a senha referente ao seu email.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
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
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Ok'),
                                      ),
                                    ],
                                  ));
                        } else {
                          FocusScope.of(context).requestFocus(FocusNode());
                          AuthService().signInWithEmailAndPassword(
                              _emailName, _passwordName, context);
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(
                          mediaquery.size.width * 0.30,
                          mediaquery.size.height * 0.07,
                        ),
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
                    SizedBox(height: mediaquery.size.height * 0.05),
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
                    SizedBox(height: mediaquery.size.height * 0.005),
                    //Botão para para enviar para tela de cadastro.
                    TextButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(
                          mediaquery.size.width * 0.38,
                          mediaquery.size.height * 0.07,
                        ),
                      ),
                      child: const Text(
                        'Criar Conta',
                        style: TextStyle(
                          color: Color(0xFF2C2F33),
                          fontFamily: 'OpenSans',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
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
