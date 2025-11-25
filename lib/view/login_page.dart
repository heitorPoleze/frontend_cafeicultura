import 'package:flutter/material.dart';
import 'package:frontend_cafeicultura/components/app_button.dart';
import 'package:frontend_cafeicultura/components/app_input.dart';
import 'package:frontend_cafeicultura/components/background_gradient.dart';
import 'package:frontend_cafeicultura/components/app_card.dart';
import 'package:frontend_cafeicultura/config/app_colors.dart';
import 'package:frontend_cafeicultura/config/test_database.dart';
import 'package:frontend_cafeicultura/utils/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // validação se os dados foram preenchidos corretamente
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is Map<String, String>) {
      _emailController.text = args['email'] ?? '';
      _passwordController.text = args['senha'] ?? '';
    }
  }

  void _fazerLogin() {
    if (_formKey.currentState!.validate()) {
      if (!TestDB.verificarLogin(
        _emailController.text,
        _passwordController.text,
      )) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Erro de Acesso'),
            content: const Text(
              'Verifique seus dados e tente novamente.',
            ), 
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }else{
        Navigator.of(context).pushReplacementNamed('/home');
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundGradient(
        child: appCard(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset('assets/images/logo.png', height: 120),
                const SizedBox(height: 24.0),
                Text(
                  'Bem-vindo(a)!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.marrom,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Faça login para acompanhar a sua produção.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: AppColors.appPreto),
                ),
                const SizedBox(height: 32.0),
                AppInput(
                  label: "E-mail",
                  hint: 'Digite seu e-mail',
                  icon: Icons.email,
                  controller: _emailController,
                  validator: Validators.validarEmail,
                ),
                const SizedBox(height: 16.0),
                AppInput(
                  label: "Senha",
                  hint: 'Digite sua senha',
                  icon: Icons.password,
                  obscureText: true,
                  controller: _passwordController,
                  validator: Validators.validarSenha,
                ),
                const SizedBox(height: 24.0),
                AppButton(
                  label: "Entrar",
                  onPressed: _fazerLogin,
                  corBase: AppColors.verdePrimaria,
                  corTexto: AppColors.appBranco,
                ),
                const SizedBox(height: 12.0),
                AppButton(
                  label: 'Não tem uma conta? Cadastre-se',
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/criarConta');
                  },
                ),
                const SizedBox(height: 12.0),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Esqueceu a senha?',
                    style: TextStyle(color: AppColors.verdePrimaria),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
