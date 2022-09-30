import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:otakusukejuru/screens/favorites_screen.dart';
import 'package:otakusukejuru/screens/sign_in_screen.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Faz com que se o usuário estiver autenticado/logado ele va direito para os favoritos
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

  // TODO corrigir fato de não ter email e senha verificados, e informar quando
  // uma conta ja existir.
  // Cadastro de login com email e senha
  signUpWithEmailAndPassword(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  //Login com email e senha pre-cadastrados
  //TODO adicionar verificação para caso conta n]ao tenha sido cadastrada
  signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      //TODO adicionar o resto das exceptions
      if (e.code == 'user-not-found') {
        showDialog(
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
      }
    }
  }

  //Login com google
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

  //Para sair da conta logada atualmente
  signOut() async {
    _auth.signOut();
    await GoogleSignIn().disconnect();
  }
}
