import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> cadastrarUsuario({
    required String email,
    required String password,
    required String nome,
    // required String photoURL,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.updateDisplayName(nome);
      // await userCredential.user!.updatePhotoURL(photoURL);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'O email já está em uso';
      }
      return e.code;
    }
    return null;
  }

  //Atualizar imagem do usuário
  Future<String?> atualizarImagemUsuario({required String photoURL}) async {
    try {
      await _firebaseAuth.currentUser!.updatePhotoURL(photoURL);
      print('Imagem atualizada com sucesso');
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return null;
  }

  Future<String?> logarUsuario(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'Usuário não encontrado';
        case 'invalid-credential':
          return 'E-mail ou senha inválidos';
      }
      return e.code;
    }
    return null;
  }

  Future<String?> redifinirSenha({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return null; // Retorna sucesso (nenhum erro)
    } on FirebaseAuthException catch (e) {
      return e.message; // Retorna a mensagem do erro, se houver
    }
  }

  Future<String?> deslogarUsuario() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return null;
  }

  Future<String?> removerConta({required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: _firebaseAuth.currentUser!.email!,
        password: password,
      );
      await _firebaseAuth.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
    return null;
  }
}
