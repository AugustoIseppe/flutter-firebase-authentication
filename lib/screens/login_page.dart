import 'package:alura_firebase_auth/authentication/services/auth_service.dart';
import 'package:alura_firebase_auth/screens/register_page.dart';
import 'package:flutter/material.dart';

import '../components/show_snackbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Lógica de autenticação (ex.: Firebase Auth)

      _authService
          .logarUsuario(
        email: _emailController.text,
        password: _passwordController.text,
      )
          .then((error) {
        if (!mounted) return;

        if (error != null) {
          showPopup(
            context: context,
            title: 'Ops! Algo deu errado',
            message: error,
            isError: true,
          );
        } else {
          Navigator.of(context).pushReplacementNamed('/home-page');
        }
      });
    }
  }

  esqueciMinhaSenha() {
    if (_emailController.text.isEmpty) {
      showPopup(
        context: context,
        title: 'E-mail não informado',
        message: 'Por favor, informe seu e-mail',
        isError: true,
      );
    } else {
      _authService.redifinirSenha(email: _emailController.text).then((error) {
        if (!mounted) return;

        if (error != null) {
          showPopup(
            context: context,
            title: 'Ops! Algo deu errado',
            message: error,
            isError: true,
          );
        } else {
          showPopup(
            context: context,
            title: 'Sucesso!',
            message:
                'O link para redefinição de senha foi enviado para o e-mail ${_emailController.text}',
            isError: false,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Firebase Auth Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Welcome Back!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                          .hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 1,
                      backgroundColor: Colors.white60,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: _login,
                    child: const Text('Login',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                        child: const Text("Não tem uma conta? Cadastre-se",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold)),
                      ),
                      InkWell(
                        onTap: () {
                          // Lógica de recuperação de senha
                          esqueciMinhaSenha();
                        },
                        child: const Text("Esqueci minha senha",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
