import 'package:flutter/material.dart';
import 'package:frontend_cafeicultura/components/app_button.dart';
import 'package:frontend_cafeicultura/components/app_input.dart';
import 'package:frontend_cafeicultura/components/background_gradient.dart';
import 'package:frontend_cafeicultura/components/app_card.dart';
import 'package:frontend_cafeicultura/config/app_colors.dart';
import 'package:frontend_cafeicultura/utils/validators.dart';

class CriarDadosPessoais extends StatefulWidget {
  const CriarDadosPessoais({super.key});

  @override
  State<CriarDadosPessoais> createState() => _CriarDadosPessoaisState();
}

class _CriarDadosPessoaisState extends State<CriarDadosPessoais> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _dddController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late Map<String, String> _dadosAutenticacao;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, String>) {
      _dadosAutenticacao = args;
    } else {
      Navigator.of(context).pushReplacementNamed('/criarConta');
    }
  }


  void _prosseguir() {
    if (_formKey.currentState!.validate()) {
      final dadosPessoais = {
        ..._dadosAutenticacao,
        'nome': _nomeController.text,
        'telefone': _telefoneController.text,
        'ddd': _dddController.text,
        'cpf': _cpfController.text,
      };
      
      // Navega para a página de endereço
      Navigator.of(context).pushNamed(
        '/criarEndereco',
        arguments: dadosPessoais,
      );
    }
  }



  @override
  void dispose() {
    _nomeController.dispose();
    _dddController.dispose();
    _telefoneController.dispose();
    _cpfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundGradient(
        child: AppCard(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset('assets/images/logo.png', height: 100),
                const SizedBox(height: 18.0),
                Text(
                  'Dados Pessoais',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.marrom,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Complete seu cadastro com seus dados pessoais.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.appPreto,
                  ),
                ),
                const SizedBox(height: 32.0),
                AppInput(
                  label: "Nome Completo",
                  hint: 'Digite seu nome completo',
                  icon: Icons.person,
                  controller: _nomeController,
                  validator: Validators.validarNome,
                ),
                const SizedBox(height: 16.0),
                AppInput(
                  label: "DDD",
                  hint: '00',
                  icon: Icons.phone,
                  controller: _dddController,
                  keyboardType: TextInputType.phone,
                  validator: Validators.validarDDD,
                ),
                const SizedBox(height: 16.0),
                AppInput(
                  label: "Telefone",
                  hint: '000000000',
                  icon: Icons.phone,
                  controller: _telefoneController,
                  keyboardType: TextInputType.phone,
                  validator: Validators.validarTelefone,
                ),
                const SizedBox(height: 16.0),
                AppInput(
                  label: "CPF",
                  hint: '00000000000',
                  icon: Icons.badge,
                  controller: _cpfController,
                  keyboardType: TextInputType.number,
                  validator: Validators.validarCPF,
                ),
                const SizedBox(height: 28.0),
                AppButton(
                  label: "Próximo",
                  onPressed: _prosseguir,
                  corBase: AppColors.verdePrimaria,
                  corTexto: AppColors.appBranco,
                ),
                const SizedBox(height: 12.0),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Voltar',
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

