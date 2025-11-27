import 'package:flutter/material.dart';
import 'package:frontend_cafeicultura/components/app_button.dart';
import 'package:frontend_cafeicultura/components/app_input.dart';
import 'package:frontend_cafeicultura/components/background_gradient.dart';
import 'package:frontend_cafeicultura/components/app_card.dart';
import 'package:frontend_cafeicultura/config/app_colors.dart';
import 'package:frontend_cafeicultura/utils/validators.dart';

class CriarEndereco extends StatefulWidget {
  const CriarEndereco({super.key});

  @override
  State<CriarEndereco> createState() => _CriarEnderecoState();
}

class _CriarEnderecoState extends State<CriarEndereco> {
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late Map<String, String> _dadosAnteriores;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is Map<String, String>) {
      _dadosAnteriores = args;
    } else {
      Navigator.of(context).pushReplacementNamed('/criarConta');
    }
  }

  void _prosseguir() {
    if (_formKey.currentState!.validate()) {
      final todosDados = {
        ..._dadosAnteriores,
        'estado': _estadoController.text,
        'cep': _cepController.text,
        'cidade': _cidadeController.text,
        'bairro': _bairroController.text,
      };
      
      // Navega para a página de dados da propriedade
      Navigator.of(context).pushNamed(
        '/criarPropriedade',
        arguments: todosDados,
      );
    }
  }

  @override
  void dispose() {
    _estadoController.dispose();
    _cepController.dispose();
    _cidadeController.dispose();
    _bairroController.dispose();
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
                  'Endereço',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.marrom,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Informe seu endereço completo.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.appPreto,
                  ),
                ),
                const SizedBox(height: 32.0),
                AppInput(
                  label: "Estado",
                  hint: 'Digite o estado (UF)',
                  icon: Icons.map,
                  controller: _estadoController,
                  validator: Validators.validarEstado,
                ),
                const SizedBox(height: 16.0),
                AppInput(
                  label: "CEP",
                  hint: '00000-000',
                  icon: Icons.location_on,
                  controller: _cepController,
                  keyboardType: TextInputType.number,
                  validator: Validators.validarCEP,
                ),
                const SizedBox(height: 16.0),
                AppInput(
                  label: "Cidade",
                  hint: 'Digite a cidade',
                  icon: Icons.location_city,
                  controller: _cidadeController,
                  validator: Validators.validarCidade,
                ),
                const SizedBox(height: 16.0),
                AppInput(
                  label: "Bairro",
                  hint: 'Digite o bairro',
                  icon: Icons.home,
                  controller: _bairroController,
                  validator: Validators.validarBairro,
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

