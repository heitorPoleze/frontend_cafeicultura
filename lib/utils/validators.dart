class Validators {
  static String? validarEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, digite o e-mail';
    }
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Formato de e-mail inválido';
    }

    return null;
  }

  static String? validarSenha(String? value) {
    if (value == null || value.isEmpty) return 'Senha obrigatória';
    if (value.length < 6) return 'Mínimo de 6 caracteres';
    return null;
  }

  static String? Function(String?) validarConfirmarSenha(String senhaOriginal) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Campo obrigatório';
      }
      if (value != senhaOriginal) {
        return 'As senhas não coincidem';
      }
      return null;
    };
  }

  static String? validarNome(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nome obrigatório';
    }
    if (value.length < 3) {
      return 'Nome deve ter ao menos 3 caracteres';
    }
    return null;
  }

  static String? validarDDD(String? value) {
    if (value == null || value.isEmpty || value.length != 2) {
      return 'DDD deve ter 2 dígitos';
    }
    return null;
  }

  static String? validarTelefone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Telefone obrigatório';
    }
    // Remove caracteres não numéricos para validação
    final apenasNumeros = value.replaceAll(RegExp(r'[^\d]'), '');
    if (apenasNumeros.length < 8 || apenasNumeros.length > 9) {
      return 'Telefone deve ter 8 ou 9 números';
    }
    return null;
  }

  static String? validarCPF(String? value) {
    if (value == null || value.isEmpty) {
      return 'CPF obrigatório';
    }
    // Remove caracteres não numéricos
    final apenasNumeros = value.replaceAll(RegExp(r'[^\d]'), '');
    if (apenasNumeros.length != 11) {
      return 'CPF deve ter 11 dígitos';
    }
    return null;
  }

  static String? validarEstado(String? value) {
    if (value == null || value.isEmpty) {
      return 'Estado obrigatório';
    }
    if (value.length < 2) {
      return 'Estado inválido';
    }
    return null;
  }

  static String? validarCEP(String? value) {
    if (value == null || value.isEmpty) {
      return 'CEP obrigatório';
    }
    final apenasNumeros = value.replaceAll(RegExp(r'[^\d]'), '');
    if (apenasNumeros.length != 8) {
      return 'CEP deve ter 8 dígitos';
    }
    return null;
  }

  static String? validarCidade(String? value) {
    if (value == null || value.isEmpty) {
      return 'Cidade obrigatória';
    }
    if (value.length < 2) {
      return 'Cidade deve ter ao menos 2 caracteres';
    }
    return null;
  }

  static String? validarBairro(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bairro obrigatório';
    }
    if (value.length < 2) {
      return 'Bairro deve ter ao menos 2 caracteres';
    }
    return null;
  }

  static String? validarHectares(String? value) {
    if (value == null || value.isEmpty) {
      return 'Hectares obrigatório';
    }
    final numero = double.tryParse(value.replaceAll(',', '.'));
    if (numero == null || numero <= 0) {
      return 'Hectares inválido';
    }
    return null;
  }

  static String? validarTrabalhadores(String? value) {
    if (value == null || value.isEmpty) {
      return 'Número de trabalhadores obrigatório';
    }
    final numero = int.tryParse(value);
    if (numero == null || numero < 0) {
      return 'Número de trabalhadores inválido';
    }
    return null;
  }
}