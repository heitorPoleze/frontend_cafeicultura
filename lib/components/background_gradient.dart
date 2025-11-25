import 'package:flutter/material.dart';
import 'package:frontend_cafeicultura/config/app_colors.dart';

class BackgroundGradient extends StatelessWidget {
  final Widget child;

  const BackgroundGradient({super.key,  this.child = const SizedBox.shrink()});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.verdePrimaria,
            AppColors.rosa,
          ],
        ),
      ),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: child
          ),
      ),
    );
  }
}

