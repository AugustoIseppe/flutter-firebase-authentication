// import 'package:firebase_storage/firebase_storage.dart';
// import 'dart:io';

// class StorageService {
//   final FirebaseStorage _storage = FirebaseStorage.instance;

//   Future<String?> uploadImage(File imageFile, String userId) async {
//     try {
//       final storageRef = _storage.ref().child('user_images/$userId.jpg');
//       final uploadTask = await storageRef.putFile(imageFile);
//       final downloadUrl = await storageRef.getDownloadURL();
//       return downloadUrl;
//     } catch (e) {
//       print('Erro ao fazer upload da imagem: $e');
//       return null;
//     }
//   }
// }
