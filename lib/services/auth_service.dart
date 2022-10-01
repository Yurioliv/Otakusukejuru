import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:otakusukejuru/screens/favorites_screen.dart';
import 'package:otakusukejuru/screens/sign_in_screen.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Faz com que se o usuário estiver autenticado/logado ele va direito para os favoritos
  handleAuthState() {
    return StreamBuilder(
      stream: _auth.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return const FavoriteScreen();
        } else {
          return const SignInScreen();
        }
      },
    );
  }

  // Cadastro de login com email e senha
  // TODO enviar tambem nome de usuario, eu acho que no FirebaseAuth é algo como DisplayName
  signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Email ja está em uso'),
            content: const Text(
                'Tente usar outro email para se cadastrar no aplicativo.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      }
      // Faz com que se acontecer uma exception o codigo apos o catch não seja executado
      return;
    }

    // Acontece se não haverem Exceptions
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(
          title: const Text('Email cadastrado'),
          content: const Text(
              'Foi mandada uma mensagem para verificação de email, por favor acesse seu email e realize a verificação.'),
          actions: [
            TextButton(
              onPressed: () => {
                Navigator.pop(context),
                // O metodo do Firebase que faz cadastro de conta de email e senha autentica automaticamente apos cadastro, então é necessario deslogar e voltar a tela de login
                signOut(),
                // Da pra colocar 2 ou mais Navigators.pop no mesmo botão, assim voltamos a tela de login
                Navigator.pop(context),
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      ),
    );
  }

  // Login com email e senha pre-cadastrados
  signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Email não cadastrado'),
            content: const Text(
                'Este email ainda não foi cadastro em nosso aplicativo, para criar um cadastro com esse email clique no botão Criar Conta.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      } else if (e.code == 'wrong-password') {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Senha incorreta'),
            content: const Text(
                'Senha incorreta ou email digitado errado, por favor tente corrigir o erro e entrar novamente.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      }
    }
  }

  // Login com google
  singInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>['email']).signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await _auth.signInWithCredential(credential);
  }

  // Para sair da conta logada atualmente
  signOut() async {
    _auth.signOut();
    await GoogleSignIn().disconnect();
  }
}