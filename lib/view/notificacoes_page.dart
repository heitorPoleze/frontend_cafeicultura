import 'package:flutter/material.dart';
import 'package:frontend_cafeicultura/config/app_colors.dart';
import 'package:frontend_cafeicultura/config/events_database.dart'; 

class NotificacoesPage extends StatefulWidget {
  const NotificacoesPage({super.key});

  @override
  State<NotificacoesPage> createState() => _NotificacoesPageState();
}

class _NotificacoesPageState extends State<NotificacoesPage> {
  List<Evento> eventosProximos = [];

  @override
  void initState() {
    super.initState();
    _carregarEventosProximos();
  }

  void _carregarEventosProximos() {
    final now = DateTime.now();
    final limiteSuperior = now.add(const Duration(days: 3));

    final proximos = EventsDB.eventos.where((evento) {
      final eventDay = DateTime(evento.data.year, evento.data.month, evento.data.day);
      final today = DateTime(now.year, now.month, now.day);
      
      return (eventDay.isAfter(today) || eventDay.isAtSameMomentAs(today)) && eventDay.isBefore(limiteSuperior);
    }).toList();

    proximos.sort((a, b) => a.data.compareTo(b.data));

    setState(() {
      eventosProximos = proximos;
    });
  }

  Widget _buildNotificationList() {
      if (eventosProximos.isEmpty) {
          return const Center(
              child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Text(
                      'Nenhum evento iminente. Tudo em ordem!',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
              ),
          );
      }
      
      return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: eventosProximos.length,
          itemBuilder: (context, index) {
              final evento = eventosProximos[index];
              String dataFormatada = '${evento.data.day}/${evento.data.month}/${evento.data.year}'; 
              
              return Card(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  elevation: 2,
                  child: ListTile(
                      leading: Icon(Icons.calendar_today, color: AppColors.verdePrimaria),
                      title: Text(evento.titulo, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Data: $dataFormatada \nDescrição: ${evento.descricao.isEmpty ? 'Sem descrição' : evento.descricao}'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
              );
          },
      );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: AppColors.verdePrimaria, 
      
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AppBar(
            title: const Text('Notificações e Lembretes', style: TextStyle(color: AppColors.appBranco)),
            backgroundColor: Colors.transparent,
            foregroundColor: AppColors.appBranco,
            elevation: 0,
          ),

          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppColors.appBranco,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Eventos Próximos',
                      style: TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold,
                        color: AppColors.marrom,
                      ),
                    ),
                    const Divider(height: 20),
                    
                    _buildNotificationList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}