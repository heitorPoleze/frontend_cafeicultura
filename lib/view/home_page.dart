import 'package:flutter/material.dart';
import 'package:frontend_cafeicultura/config/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:frontend_cafeicultura/config/events_database.dart';
import 'package:frontend_cafeicultura/config/test_database.dart';
import 'package:frontend_cafeicultura/components/app_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  late final ValueNotifier<List<Evento>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  List<Evento> _getEventsForDay(DateTime day) {
    return EventsDB.getEventosParaDia(day);
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) async {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventsForDay(selectedDay);
      });
      await Navigator.of(
        context,
      ).pushNamed('/cadastrarEvento', arguments: selectedDay);
      setState(() => _selectedEvents.value = _getEventsForDay(_selectedDay!));
    }
  }

  Widget _buildFinancialSummary(BuildContext context) {
    const double receita = 14700.00;
    const double despesa = 11850.00;
    final double saldo = receita - despesa;
    final Color saldoColor = saldo > 0
        ? Colors.green.shade700
        : AppColors.marrom;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/relatorioFinanceiro');
      },
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Resumo Financeiro ${DateTime.now().month}/${DateTime.now().year}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.verdePrimaria,
                  ),
                ),
                const Icon(Icons.show_chart, color: AppColors.verdePrimaria),
              ],
            ),
            const Divider(height: 20),

            _buildFinanceRow(
              'Receita Bruta:',
              'R\$ ${receita.toStringAsFixed(2)}',
              Colors.green,
            ),
            _buildFinanceRow(
              'Total de Despesas:',
              'R\$ ${despesa.toStringAsFixed(2)}',
              Colors.red,
            ),
            const Divider(height: 20),
            _buildFinanceRow(
              'Saldo Líquido:',
              'R\$ ${saldo.toStringAsFixed(2)}',
              saldoColor,
            ),

            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Toque para ver o relatório completo',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinanceRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  String get _userName {
    final userData = TestDB.getDadosPessoais();
    final nomeCompleto = userData?['nome'] ?? 'Usuário';
    return nomeCompleto.split(' ')[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBranco,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColors.verdePrimaria,
        foregroundColor: AppColors.appBranco,

        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset('assets/images/logo.png', height: 56),
              ],
            ),
          ),
        ),
        leadingWidth: 100,

        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications_none),
            tooltip: 'Notificações',
            onPressed: () {
              Navigator.of(context).pushNamed('/notificacoes');
            },
          ),
          IconButton(
            icon: const Icon(Icons.person_outline),
            tooltip: 'Perfil',
            onPressed: () {
              Navigator.of(context).pushNamed('/editarDados');
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Bem-vindo(a), $_userName!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: AppColors.marrom,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Visão geral da sua fazenda:',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TableCalendar<Evento>(
                  focusedDay: _focusedDay,
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: _onDaySelected,

                  eventLoader: _getEventsForDay,

                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) {
                      if (events.isNotEmpty) {
                        return Positioned(
                          right: 1,
                          bottom: 1,
                          child: Container(
                            width: 6.0,
                            height: 6.0,
                            decoration: const BoxDecoration(
                              color: AppColors.verdePrimaria,
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      }
                      return null;
                    },
                  ),

                  calendarFormat: _calendarFormat,
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },

                  locale: 'pt_BR',
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Mês ➡️',
                    CalendarFormat.twoWeeks: '2 semanas ➡️',
                    CalendarFormat.week: 'Semana ➡️',
                  },
                  headerStyle: HeaderStyle(
                    formatButtonVisible: true,
                    titleCentered: true,
                    titleTextStyle: TextStyle(
                      color: AppColors.marrom,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: AppColors.verdePrimaria,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: AppColors.verdePrimaria,
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                      color: AppColors.verdePrimaria,
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: const TextStyle(
                      color: AppColors.appBranco,
                      fontWeight: FontWeight.bold,
                    ),

                    todayDecoration: BoxDecoration(
                      color: AppColors.verdePrimaria.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(
                      color: AppColors.marrom,
                      fontWeight: FontWeight.bold,
                    ),

                    weekendTextStyle: TextStyle(
                      color: AppColors.marrom.withValues(alpha: 0.8),
                    ),
                    defaultTextStyle: const TextStyle(
                      color: AppColors.appPreto,
                    ),
                    outsideDaysVisible: false,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            _buildFinancialSummary(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
