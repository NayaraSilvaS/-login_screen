class AuthService {
  Future<String> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email.isEmpty || password.isEmpty) {
      throw Exception("Preencha todos os campos");
    }

    if (!email.contains('@')) {
      throw Exception("Email inválido");
    }

    if (password.length < 8) {
      throw Exception("Senha deve ter pelo menos 8 caracteres");
    }

    return "fake_token_123";
  }
}
