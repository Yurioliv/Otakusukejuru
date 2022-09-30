import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

//TextField para email
class EmailTextField extends StatelessWidget {
  const EmailTextField(
      {required this.texto, required this.controlador, super.key});
  final String texto;
  final TextEditingController controlador;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TextFormField(
        controller: controlador,
        style: const TextStyle(color: Color(0xFF2C2F33)),
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          hintText: texto,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (email) => email != null && !EmailValidator.validate(email)
            ? 'Coloque um email valido'
            : null,
      ),
    );
  }
}

//TextField para nome de usuario
class UserTextField extends StatelessWidget {
  const UserTextField(
      {required this.texto, required this.controlador, super.key});
  final String texto;
  final TextEditingController controlador;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TextFormField(
        controller: controlador,
        style: const TextStyle(color: Color(0xFF2C2F33)),
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          hintText: texto,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => value == null || value.isEmpty
            ? 'O nome de usuario não pode estar vazio'
            : null,
      ),
    );
  }
}

//TextField para senhas
class PasswordTextField extends StatelessWidget {
  const PasswordTextField(
      {required this.texto, required this.controlador, super.key});
  final String texto;
  final TextEditingController controlador;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: TextFormField(
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        controller: controlador,
        style: const TextStyle(color: Color(0xFF2C2F33)),
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          hintText: texto,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => value != null && value.length < 8
            ? 'A senha deve ter pelo menos 8 caracteres'
            : null,
      ),
    );
  }
}
