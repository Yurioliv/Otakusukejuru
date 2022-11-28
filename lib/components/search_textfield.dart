import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controlador;

  const SearchTextField({super.key, required this.controlador});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controlador,
      style: const TextStyle(color: Colors.white),
      autofocus: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: const Color(0xFF2C2F33),
        hintText: "Digite o nome da obra ou parte dele",
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
