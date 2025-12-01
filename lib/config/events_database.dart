class Evento {
  final String titulo;
  final String descricao;
  final DateTime data;

  Evento({required this.titulo, required this.descricao, required this.data});

  @override
  String toString() {
    return '$titulo em ${data.day}/${data.month}/${data.year}';
  }
}

class EventsDB {
  static final List<Evento> eventos = [];

  static void adicionarEvento(Evento evento) {
    eventos.add(evento);
  }
  
  static List<Evento> getEventosParaDia(DateTime day) {
    return eventos.where((e) => 
      e.data.year == day.year &&
      e.data.month == day.month &&
      e.data.day == day.day
    ).toList();
  }
}