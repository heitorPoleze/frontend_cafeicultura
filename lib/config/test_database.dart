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
}
