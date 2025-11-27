import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:frontend_cafeicultura/view/criar_autenticacao.dart';
import 'package:frontend_cafeicultura/view/criar_dados_pessoais.dart';
import 'package:frontend_cafeicultura/view/criar_endereco.dart';
import 'package:frontend_cafeicultura/view/criar_propriedade.dart';
import 'package:frontend_cafeicultura/view/login_page.dart';
import 'package:frontend_cafeicultura/view/home_page.dart';
import 'package:frontend_cafeicultura/view/editar_dados_pessoais.dart';
import 'config/app_colors.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroGest - Gestão para Cafeicultores',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.verdePrimaria),
      ),
       initialRoute: '/',
       routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/criarConta' : (context) => const CriarAutenticacao(),
        '/dadosPessoais': (context) => const CriarDadosPessoais(),
        '/criarEndereco' : (context) => const CriarEndereco(),
        '/criarPropriedade' : (context) => const CriarPropriedade(),
        '/editarDados' : (context) => const EditarDadosPessoais(),
      },
    );
  }
}