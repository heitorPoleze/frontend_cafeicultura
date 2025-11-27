import 'package:flutter/material.dart';
import 'package:frontend_cafeicultura/config/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBranco,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColors.verdePrimaria,
        foregroundColor: AppColors.appBranco,

        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset('assets/images/logo.png', height: 56),
              ],
            ),
          ),
        ),
        leadingWidth: 50,

        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications_none),
            tooltip: 'Notificações',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Oops!'),
                  content: const Text(
                    'Funcionalidade de notificações indisponível. Aguarde novas atualizações.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            tooltip: 'Perfil',
            onPressed: () {
              Navigator.of(context).pushNamed('/editarDados');
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bem-vindo(a) ao AgroGest!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.rosa,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Estamos trabalhando para trazer mais funcionalidades em breve!',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
