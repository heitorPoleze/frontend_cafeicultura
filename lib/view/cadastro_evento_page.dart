import 'package:flutter/material.dart';
import 'package:frontend_cafeicultura/components/app_button.dart';
import 'package:frontend_cafeicultura/components/app_input.dart';
import 'package:frontend_cafeicultura/config/app_colors.dart';
import 'package:frontend_cafeicultura/config/events_database.dart'; 

class CadastroEventoPage extends StatefulWidget {
  final DateTime selectedDate;

  const CadastroEventoPage({super.key, required this.selectedDate});

  @override
  State<CadastroEventoPage> createState() => _CadastroEventoPageState();
}

class _CadastroEventoPageState extends State<CadastroEventoPage> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  
  List<Evento> _eventosDoDia = []; 

  @override
  void initState() {
    super.initState();
    _loadExistingEvents();
  }

  void _loadExistingEvents() {
    final existingEvents = EventsDB.getEventosParaDia(widget.selectedDate);
    
    setState(() {
      _eventosDoDia = existingEvents;
    });
  }

  void _salvarEvento() {
    if (_formKey.currentState!.validate()) {
      
      final novoEvento = Evento(
        titulo: _tituloController.text,
        descricao: _descricaoController.text,
        data: widget.selectedDate,
      );

      EventsDB.adicionarEvento(novoEvento); 
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Evento "${_tituloController.text}" salvo para ${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}!'),
          backgroundColor: AppColors.verdePrimaria,
        ),
      );
      
      Navigator.of(context).pop();
    }
  }
  
  Widget _buildExistingEventsList() {
    if (_eventosDoDia.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        
        Text(
          'Tarefas do dia selecionado:',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.marrom,
          ),
        ),
        const SizedBox(height: 10),

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _eventosDoDia.length,
          itemBuilder: (context, index) {
            final event = _eventosDoDia[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 8.0),
              color: AppColors.marrom.withValues(alpha: 0.1),
              elevation: 0,
              child: ListTile(
                leading: const Icon(Icons.check_circle_outline, color: AppColors.marrom),
                title: Text(
                  event.titulo,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(event.descricao.isEmpty ? 'Sem descrição' : event.descricao),
                // Adicione a ação de visualização/edição aqui se necessário
                onTap: () {},
              ),
            );
          },
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    String formattedDate = 
        '${widget.selectedDate.day.toString().padLeft(2, '0')}/'
        '${widget.selectedDate.month.toString().padLeft(2, '0')}/'
        '${widget.selectedDate.year}';
        
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Evento'),
        backgroundColor: AppColors.verdePrimaria,
        foregroundColor: AppColors.appBranco,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cadastrar Evento para: $formattedDate',
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold, 
                  color: AppColors.marrom,
                ),
              ),
              const SizedBox(height: 24),
              
              AppInput(
                label: "Título do Evento",
                hint: 'Ex: Irrigação do Lote C',
                icon: Icons.title,
                controller: _tituloController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O título não pode ser vazio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _descricaoController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Descrição/Notas",
                  hintText: 'Detalhes da atividade ou observações',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
              ),
              const SizedBox(height: 32),

              AppButton(
                label: 'Salvar Evento',
                onPressed: _salvarEvento,
                corBase: AppColors.verdePrimaria,
                corTexto: AppColors.appBranco,
              ),
              
              _buildExistingEventsList(),

            ],
          ),
        ),
      ),
    );
  }
}