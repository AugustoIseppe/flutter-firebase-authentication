import 'dart:io';

import 'package:alura_firebase_auth/authentication/services/auth_service.dart';
import 'package:alura_firebase_auth/components/show_confirm_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  final User user;
  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService _authService = AuthService();
  File? _selectedImage;

  Future<void> _pickImage() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: _selectedImage != null
                  ? GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                          radius: 80,
                          backgroundImage: _selectedImage == null
                              ? NetworkImage(widget.user.photoURL!)
                              : null,
                          child: const Text('')),
                    )
                  : GestureDetector(
                      onTap: _pickImage,
                      child: const SizedBox(
                        child: CircleAvatar(
                            radius: 80,
                            child: Icon(Icons.person,
                                size: 40, color: Colors.grey)),
                      ),
                    ),
              accountName:
                  Text((user.displayName! != null) ? user.displayName! : ''),
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
            ListTile(
              title: const Text('Alterar imagem'),
              onTap: () {
                print(_selectedImage!.path);
                _authService.atualizarImagemUsuario(
                    photoURL: _selectedImage!.path);
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
          Text('Olá, seja bem-vindo ao app ${user.displayName}!'),
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
