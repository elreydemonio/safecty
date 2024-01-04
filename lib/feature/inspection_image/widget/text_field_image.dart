import 'package:flutter/material.dart';

class MyCustomTextField extends StatelessWidget {
  const MyCustomTextField({
    super.key,
    required this.required,
    required this.textEditingController,
    required this.validator,
  });

  final bool required;
  final TextEditingController textEditingController;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      enabled: required,
      validator: validator,
      style: const TextStyle(color: Colors.black),
      decoration: const InputDecoration(
        icon: Icon(Icons.edit, color: Colors.black),
        hintText: 'Ingrese su texto aquí',
        hintStyle: TextStyle(color: Colors.grey),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        filled: false,
      ),
    );
  }
}
