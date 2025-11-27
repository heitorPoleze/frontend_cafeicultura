
import 'package:flutter/material.dart';
import 'package:frontend_cafeicultura/components/app_button.dart';
import 'package:frontend_cafeicultura/components/app_input.dart';
import 'package:frontend_cafeicultura/components/background_gradient.dart';
import 'package:frontend_cafeicultura/components/app_card.dart';
import 'package:frontend_cafeicultura/config/app_colors.dart';
import 'package:frontend_cafeicultura/config/test_database.dart';
import 'package:frontend_cafeicultura/utils/validators.dart';

class CriarPropriedade extends StatefulWidget {
  const CriarPropriedade({super.key});

  @override
  State<CriarPropriedade> createState() => _CriarPropriedadeState();
}

class _CriarPropriedadeState extends State<CriarPropriedade> {
  final TextEditingController _hectaresController = TextEditingController();
  final TextEditingController _trabalhadoresController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late Map<String, String> _dadosAnteriores;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, String>) {
      _dadosAnteriores = args;
    } else {
      // Navigator.of(context).pushReplacementNamed('/criarConta');
    }
  }

  void _finalizarCadastro() {
    if (_formKey.currentState!.validate()) {
      final todosDados = {
        ..._dadosAnteriores,
        'hectares': _hectaresController.text,
        'trabalhadores': _trabalhadoresController.text,
      };
      
      TestDB.adicionarUsuario(todosDados);

      Navigator.of(context).pushReplacementNamed(
        '/',
        arguments: {
          'email': _dadosAnteriores['email'],
          'senha': _dadosAnteriores['senha'],
        }
      );
    }
  }

  @override
  void dispose() {
    _hectaresController.dispose();
    _trabalhadoresController.dispose();
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
                  'Dados da Propriedade',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.marrom,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Informe os dados da sua propriedade.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.appPreto,
                  ),
                ),
                const SizedBox(height: 32.0),
                AppInput(
                  label: "Hectares",
                  hint: 'Digite a área em hectares',
                  icon: Icons.agriculture,
                  controller: _hectaresController,
                  keyboardType: TextInputType.number,
                  validator: Validators.validarHectares,
                ),
                const SizedBox(height: 16.0),
                AppInput(
                  label: "Número de Trabalhadores",
                  hint: 'Digite o número de trabalhadores',
                  icon: Icons.people,
                  controller: _trabalhadoresController,
                  keyboardType: TextInputType.number,
                  validator: Validators.validarTrabalhadores,
                ),
                const SizedBox(height: 28.0),
                AppButton(
                  label: "Finalizar Cadastro",
                  onPressed: _finalizarCadastro,
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
