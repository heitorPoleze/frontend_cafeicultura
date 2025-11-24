import 'package:flutter/material.dart';
import 'package:frontend_cafeicultura/config/app_colors.dart';

class AppButton extends StatelessWidget {

  final String label;
  final VoidCallback onPressed;
  final Color? corBase; 
  final Color? corHover; 
  final Color? corTexto;
  final Color? corTextoHover;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.corBase,
    this.corHover,
    this.corTexto,
    this.corTextoHover,
  });

  @override
  Widget build(BuildContext context) {
    final colorDefault = corBase ?? AppColors.appBranco;
    final hoverDefault = corHover ?? AppColors.marrom;
    final Color textDefault = corTexto ?? AppColors.marrom;
    final Color textHoverDefault = corTextoHover ?? AppColors.appBranco;

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 16.0),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.hovered)) {
            return textHoverDefault;
          }
          return textDefault;
        }),
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.hovered)) {
            return hoverDefault;
          }
          return colorDefault;
        }),
        textStyle: WidgetStateProperty.all(
          const TextStyle(fontSize: 25.0),
        ),
      ),
      child: Text(
        label,
      ),
    );
  }
}