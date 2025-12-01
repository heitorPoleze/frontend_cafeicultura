import 'package:flutter/material.dart';
import 'package:frontend_cafeicultura/config/app_colors.dart';

class AppCard extends StatelessWidget {
  final Widget child;

  const AppCard({
    super.key, 
    required this.child
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      decoration: BoxDecoration(
        color: AppColors.branco,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.appPreto,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}