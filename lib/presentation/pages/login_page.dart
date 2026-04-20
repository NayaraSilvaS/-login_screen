import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import '../stores/login_store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final store = LoginStore();

  late ReactionDisposer disposer;

  @override
  void initState() {
    super.initState();

    disposer = reaction<bool>((_) => store.isSuccess, (success) {
      if (success) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  void dispose() {
    disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0C10),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Observer(
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),

                const Text(
                  "Entrar",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 30),

                _input(
                  hint: "Email",
                  onChanged: store.setEmail,
                  error: store.isEmailValid ? null : "Email inválido",
                ),

                const SizedBox(height: 20),

                _input(
                  hint: "Senha",
                  obscure: true,
                  onChanged: store.setPassword,
                ),

                const SizedBox(height: 16),

                ...store.passwordRules.entries.map(
                  (e) => _rule(e.key, e.value),
                ),

                if (store.error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      store.error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),

                const Spacer(),

                ElevatedButton(
                  onPressed:
                      store.isFormValid && !store.isLoading
                          ? () => store.login()
                          : null,
                  child: store.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Entrar"),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _input({
    required String hint,
    required Function(String) onChanged,
    bool obscure = false,
    String? error,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          obscureText: obscure,
          onChanged: onChanged,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            errorText: error,
            filled: true,
            fillColor: const Color(0xFF16181D),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _rule(String key, bool value) {
    final map = {
      "length": "Mínimo 8 caracteres",
      "uppercase": "Maiúscula",
      "lowercase": "Minúscula",
      "number": "Número",
      "special": "Especial",
    };

    return Row(
      children: [
        Icon(
          value ? Icons.check : Icons.close,
          color: value ? Colors.green : Colors.grey,
        ),
        const SizedBox(width: 6),
        Text(map[key]!, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
