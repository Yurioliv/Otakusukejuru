import 'package:flutter/material.dart';

Widget loginTextField(String texto, TextEditingController controlador) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40.0),
    child: TextField(
      controller: controlador,
      style: const TextStyle(color: Color(0xFF2C2F33)),
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.white,
        hintText: texto,
      ),
    ),
  );
}

Widget passwordTextField(String texto, TextEditingController controlador) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40.0),
    child: TextField(
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
    ),
  );
}
