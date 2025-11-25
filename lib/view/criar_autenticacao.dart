import 'package:flutter/material.dart';
import 'package:frontend_cafeicultura/components/app_button.dart';
import 'package:frontend_cafeicultura/components/app_input.dart';
import 'package:frontend_cafeicultura/components/background_gradient.dart';
import 'package:frontend_cafeicultura/components/app_card.dart';
import 'package:frontend_cafeicultura/config/app_colors.dart';
import 'package:frontend_cafeicultura/utils/validators.dart';

class CriarAutenticacao extends StatefulWidget {
  const CriarAutenticacao({super.key});

  @override
  State<CriarAutenticacao> createState() => _CriarAutenticacaoState();
}

class _CriarAutenticacaoState extends State<CriarAutenticacao> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _criarConta() {
    if (_formKey.currentState!.validate()) {
      final dadosAutenticacao = {
        'email': _emailController.text,
        'senha': _passwordController.text,
      };
      
      Navigator.of(context).pushNamed(
        '/dadosPessoais',
        arguments: dadosAutenticacao,
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                    Image.asset('assets/images/logo.png', height: 100),
                    const SizedBox(height: 18.0),
                    Text(
                      'Criar Conta',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.marrom,
                      ),
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
                    const SizedBox(height: 16.0),
                    AppInput(
                      label: "Confirmar Senha",
                      hint: 'Repita sua senha',
                      icon: Icons.lock_outline,
                      obscureText: true,
                      controller: _confirmPasswordController,
                      validator: (value) => Validators.validarConfirmarSenha(_passwordController.text)(value),
                    ),
                    const SizedBox(height: 28.0),
                    AppButton(
                      label: "Criar Conta",
                      onPressed: _criarConta,
                      corBase: AppColors.verdePrimaria,
                      corTexto: AppColors.appBranco,
                    ),
                    const SizedBox(height: 12.0),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/');
                      },
                      child: Text(
                        'Já tem uma conta? Entrar',
                        style: TextStyle(
                          color: AppColors.verdePrimaria,
                          fontWeight: FontWeight.w600,
                        ),
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
