import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {

  final String label;
  final VoidCallback onPressed; //precisa realizar alguma ação
  final Color? corBase; 
  final Color? corHover; 

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.corBase,
    this.corHover,
  });

  @override
  Widget build(BuildContext context) {
    // Definindo cores padrão caso não sejam passadas (Fallbacks)
    final colorDefault = corBase ?? Theme.of(context).colorScheme.primary;
    final hoverDefault = corHover ?? Colors.green.shade600;

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 16.0),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        // A Lógica de Cor Dinâmica fica encapsulada aqui
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.hovered)) {
            return hoverDefault; // Usa a prop de hover ou o padrão
          }
          return colorDefault; // Usa a prop de cor base ou o padrão
        }),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 25.0, color: Colors.white),
      ),
    );
  }
}