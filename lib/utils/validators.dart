class Validators {
  static String? validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite o e-mail';
    }
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Formato de e-mail inválido';
    }

    return null; // Sucesso (????)
  }

  static String? validarSenha(String? value) {
    if (value == null || value.isEmpty) return 'Senha obrigatória';
    if (value.length < 6) return 'Mínimo de 6 caracteres';
    return null;
  }
}