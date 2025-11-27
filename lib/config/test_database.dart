// fake_db.dart
class TestDB {
  static List<Map<String, dynamic>> usuarios = [];

  static void adicionarUsuario(Map<String, dynamic> usuario) {
    var usuarioEncontrado = TestDB.usuarios.firstWhere(
      (user) => user['email'] == usuario['email'],

      orElse: () => {},
    );
    if (usuarioEncontrado.isEmpty) usuarios.add(usuario);
  }

  static bool verificarLogin(String email, String senha) {
    for (var user in usuarios) {
      if (user['email'] == email && user['senha'] == senha) {
        return true;
      }
    }
    return false;
  }

  static Map<String, String>? getDadosPessoais() {
    if (usuarios.isNotEmpty) {
      var user = usuarios[0];
      return {
        'nome': user['nome'] ?? '',
        'ddd': user['ddd'] ?? '',
        'telefone': user['telefone'] ?? '',
        'estado': user['estado'] ?? '',
        'cep': user['cep'] ?? '',
        'cidade': user['cidade'] ?? '',
        'bairro': user['bairro'] ?? '',
        'hectares': user['hectares'] ?? '',
        'trabalhadores': user['trabalhadores'] ?? '',
      };
    }
    return null;
  }

  static void atualizarDadosPessoais(Map<String, String> novosDados) {
    if (usuarios.isNotEmpty) {
      var user = usuarios[0];
      user['nome'] = novosDados['nome'];
      user['ddd'] = novosDados['ddd'];
      user['telefone'] = novosDados['telefone'];
      user['estado'] = novosDados['estado'];
      user['cep'] = novosDados['cep'];
      user['cidade'] = novosDados['cidade'];
      user['bairro'] = novosDados['bairro'];
      user['hectares'] = novosDados['hectares'];
      user['trabalhadores'] = novosDados['trabalhadores'];
    }
  }
}
