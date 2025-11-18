import 'package:flutter/material.dart';
import 'package:frontend_cafeicultura/components/app_button.dart';
import 'package:frontend_cafeicultura/components/app_input.dart';
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

  void _fazerLogin() {
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text;
      final String password = _passwordController.text;
      
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  //dispose limpa os controladores
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
           Image.asset('assets/images/logo.png', height: 120),

              const SizedBox(height: 48.0),
              //minha classe de input (components)
              AppInput(
                label: "E-mail", 
                hint: 'Digite seu e-mail', 
                icon: Icons.email, 
                controller: _emailController, 
                validator: Validators.validarEmail
                ),

              const SizedBox(height: 16.0),

              AppInput(
                label: "Senha", 
                hint: 'Digite sua senha', 
                icon: Icons.password, 
                obscureText: true,
                controller: _passwordController, 
                validator: Validators.validarSenha
                ),

              const SizedBox(height: 16.0),
              //minha classe de botão
              AppButton(
                label: "Entrar", 
                onPressed: _fazerLogin,
                )
            ],
          ),
        ),
      ),
    );
  }
}
