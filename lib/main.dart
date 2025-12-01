import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:frontend_cafeicultura/view/criar_autenticacao.dart';
import 'package:frontend_cafeicultura/view/criar_dados_pessoais.dart';
import 'package:frontend_cafeicultura/view/criar_endereco.dart';
import 'package:frontend_cafeicultura/view/criar_propriedade.dart';
import 'package:frontend_cafeicultura/view/login_page.dart';
import 'package:frontend_cafeicultura/view/home_page.dart';
import 'package:frontend_cafeicultura/view/editar_dados_pessoais.dart';
import 'package:frontend_cafeicultura/view/cadastro_evento_page.dart';
import 'package:frontend_cafeicultura/view/notificacoes_page.dart';
import 'package:frontend_cafeicultura/view/relatorio_financeiro_page.dart';
import 'config/app_colors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroGest - Gestão para Cafeicultores',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.verdePrimaria),
        useMaterial3: true,
      ),

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],

      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/criarConta': (context) => const CriarAutenticacao(),
        '/dadosPessoais': (context) => const CriarDadosPessoais(),
        '/criarEndereco': (context) => const CriarEndereco(),
        '/criarPropriedade': (context) => const CriarPropriedade(),
        '/editarDados': (context) => const EditarDadosPessoais(),
        '/notificacoes': (context) => const NotificacoesPage(),
        '/relatorioFinanceiro': (context) => const RelatorioFinanceiroPage(),
      },
      
      onGenerateRoute: (settings) {
        if (settings.name == '/cadastrarEvento') {
          final args = settings.arguments as DateTime?; 
          
          if (args != null) {
            return MaterialPageRoute(
              builder: (context) {
                return CadastroEventoPage(selectedDate: args);
              },
            );
          }
          return MaterialPageRoute(builder: (context) => const HomePage());
        }
        return null;
      },
    );
  }
}