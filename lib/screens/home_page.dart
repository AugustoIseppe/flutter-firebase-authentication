import 'package:alura_firebase_auth/authentication/services/auth_service.dart';
import 'package:alura_firebase_auth/components/show_confirm_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              // ignore: unnecessary_null_comparison
              accountName: Text((widget.user.displayName! != null)
                  ? widget.user.displayName!
                  : ''),
              accountEmail: Text(widget.user.email!),
            ),
            ListTile(
              title: const Text('Sobre'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Sobre o app'),
                      content: const Text(
                          'Este app foi desenvolvido para o curso de Flutter e Firebase da Alura.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Fechar'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              title: const Text('Sair'),
              onTap: () {
                AuthService().deslogarUsuario();
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bem-vindo'),
      ),
      body: Center(
          child: Column(
        children: [
          const SizedBox(height: 20),
          const Text('Olá, seja bem-vindo ao app!'),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () {
              AuthService().deslogarUsuario();
            },
            child: const Text('Deslogar'),
          ),
          FilledButton(
            onPressed: () {
              showConfirmPasswordDialog(context: context, email: '');
            },
            child: const Text('Excluir conta'),
          ),
        ],
      )),
    );
  }
}
