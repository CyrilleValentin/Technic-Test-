import 'package:flutter/material.dart';

Widget myInput({
  bool obscureText = false,
  Widget? suffixIcon,
  TextInputType? keyboardType,
  required String prefixText,
  required TextEditingController controller,
  String? Function(String?)? validator,
  void Function(String?)? onSaved,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.all(12),
      prefixText: prefixText,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      filled: true,
      fillColor: Colors.white,
      errorStyle: const TextStyle(
        color: Colors.red,
        fontSize: 12,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: Colors.red, width: 1),
      ),
    ),
    keyboardType: keyboardType,
    validator: validator,
    onSaved: onSaved,
  );
}