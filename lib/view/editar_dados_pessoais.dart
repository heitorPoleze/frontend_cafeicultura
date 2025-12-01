import 'package:flutter/material.dart';
import 'package:frontend_cafeicultura/components/app_button.dart';
import 'package:frontend_cafeicultura/components/app_input.dart';
import 'package:frontend_cafeicultura/components/background_gradient.dart';
import 'package:frontend_cafeicultura/components/app_card.dart';
import 'package:frontend_cafeicultura/config/app_colors.dart';
import 'package:frontend_cafeicultura/config/test_database.dart';
import 'package:frontend_cafeicultura/utils/validators.dart';

class EditarDadosPessoais extends StatefulWidget {
  const EditarDadosPessoais({super.key});

  @override
  State<EditarDadosPessoais> createState() => _EditarDadosPessoaisState();
}

class _EditarDadosPessoaisState extends State<EditarDadosPessoais> {
  // Controladores para os campos de formulário
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _dddController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _hectaresController = TextEditingController();
  final TextEditingController _trabalhadoresController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    final userData = TestDB.getDadosPessoais();

    if (userData != null) {
      _nomeController.text = userData['nome'] ?? '';
      _dddController.text = userData['ddd'] ?? '';
      _telefoneController.text = userData['telefone'] ?? '';
      _estadoController.text = userData['estado'] ?? '';
      _cepController.text = userData['cep'] ?? '';
      _cidadeController.text = userData['cidade'] ?? '';
      _bairroController.text = userData['bairro'] ?? '';
      _hectaresController.text = userData['hectares'] ?? '';
      _trabalhadoresController.text = userData['trabalhadores'] ?? '';

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = "Erro ao carregar dados. Usuário não encontrado.";
      });
    }
  }

  void _salvarEdicao() {
    if (_formKey.currentState!.validate()) {
      final novosDados = {
        'nome': _nomeController.text,
        'ddd': _dddController.text,
        'telefone': _telefoneController.text,
        'estado': _estadoController.text,
        'cep': _cepController.text,
        'cidade': _cidadeController.text,
        'bairro': _bairroController.text,
        'hectares': _hectaresController.text,
        'trabalhadores': _trabalhadoresController.text,
      };

      TestDB.atualizarDadosPessoais(novosDados);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Dados pessoais atualizados com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Editar Dados Pessoais',
          style: TextStyle(
            color: AppColors.appBranco,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.appBranco,
      ),
      extendBodyBehindAppBar: true,
      body: BackgroundGradient(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.appBranco),
              )
            : _errorMessage != null
            ? Center(
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 18),
                ),
              )
            : AppCard(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 16.0),
                      AppInput(
                        label: "Nome Completo",
                        hint: 'Digite seu nome',
                        icon: Icons.person,
                        controller: _nomeController,
                        validator: Validators.validarNome,
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 3,
                            child: AppInput(
                              label: "DDD",
                              hint: '00',
                              icon: Icons.phone,
                              controller: _dddController,
                              keyboardType: TextInputType.phone,
                              validator: Validators.validarDDD,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Flexible(
                            flex: 9,
                            child: AppInput(
                              label: "Telefone",
                              hint: '000000000',
                              icon: Icons.phone,
                              controller: _telefoneController,
                              keyboardType: TextInputType.phone,
                              validator: Validators.validarTelefone,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 3,
                            child: AppInput(
                              label: "UF",
                              hint: 'XX',
                              icon: Icons.location_pin,
                              controller: _estadoController,
                              validator: Validators.validarEstado,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Flexible(
                            flex: 9,
                            child: AppInput(
                              label: "Cidade",
                              hint: 'Digite sua cidade',
                              icon: Icons.location_city,
                              controller: _cidadeController,
                              validator: Validators.validarCidade,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      AppInput(
                        label: "Bairro",
                        hint: 'Digite seu bairro',
                        icon: Icons.home,
                        controller: _bairroController,
                        validator: Validators.validarBairro,
                      ),
                      const SizedBox(height: 16.0),
                      AppInput(
                        label: "Hectares",
                        hint: 'Digite o tamanho da sua propriedade',
                        icon: Icons.agriculture,
                        controller: _hectaresController,
                        keyboardType: TextInputType.number,
                        validator: Validators.validarHectares,
                      ),
                      const SizedBox(height: 16.0),
                      AppInput(
                        label: "Colaboradores",
                        hint: 'Quantidade de trabalhadores',
                        icon: Icons.people,
                        controller: _trabalhadoresController,
                        keyboardType: TextInputType.number,
                        validator: Validators.validarTrabalhadores,
                      ),
                      const SizedBox(height: 28.0),
                      AppButton(
                        label: "Salvar Edição",
                        onPressed: _salvarEdicao,
                        corBase: AppColors.verdePrimaria,
                        corTexto: AppColors.appBranco,
                      ),
                      const SizedBox(height: 12.0),

                      // Botão para Voltar
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancelar e Voltar',
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
