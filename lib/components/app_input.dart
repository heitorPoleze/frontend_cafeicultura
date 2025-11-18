import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  final String label;
  final String hint;
  final IconData? icon;
  final TextEditingController controller;
  final String? Function(String?) validator; 
  final bool obscureText;
  final TextInputType keyboardType;

  const AppInput({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.validator,
    this.icon,
    this.obscureText = false, 
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      
      style: const TextStyle(fontSize: 20), 
      
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 18),
        hintText: hint,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      
      validator: validator,
    );
  }
}