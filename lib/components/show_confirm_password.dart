// ignore_for_file: use_build_context_synchronously

import 'package:alura_firebase_auth/authentication/services/auth_service.dart';
import 'package:flutter/material.dart';

showConfirmPasswordDialog({
  required BuildContext context,
  required String email,
}) {
  showDialog(
    context: context,
    builder: (context) {
      TextEditingController confirmPasswordController = TextEditingController();
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Row(
          children: [
            Icon(
              Icons.lock_outline,
              color: Colors.deepOrange,
            ),
            SizedBox(width: 8),
            Text(
              'Confirme sua senha',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Para excluir sua conta $email, é necessário confirmar sua senha:',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Lógica para confirmação
              AuthService()
                  .removerConta(password: confirmPasswordController.text)
                  .then((String? error) {
                if (error == null) {
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Erro ao excluir conta: $error',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              });
            },
            child: const Text(
              'Excluir conta',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}
