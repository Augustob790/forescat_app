import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../domain/models/user_model.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class FirebaseAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fire = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  User? usuario;
  User? usuarioFire;
  bool isLoading = true;

  FirebaseAuthService() {
    authCheck();
  }

  addUserDetails(String email, String senha) async {
    await fire.collection("users").add({
      "email": email,
      "senha": senha,
    });
  }

  authCheck() {
    auth.authStateChanges().listen((User? user) {
      usuario = (user == null) ? null : user;
      isLoading = false;
    });
  }

  getUser() {
    usuario = auth.currentUser;
  }

//levar usuario para a home page;
  Future<UserModel> getUserFire() async {
    DocumentSnapshot snap =
        await fire.collection("users").doc(usuario?.uid).get();
    return UserModel.userData(snap);
  }

  Future<String> uploadImage(String path, Uint8List file) async {
    try {
      Reference ref = storage.ref().child(path);
      UploadTask task = ref.putData(file);
      TaskSnapshot snapshot = await task;
      String download = await snapshot.ref.getDownloadURL();
      return download;
    } on FirebaseException catch (e) {
      throw Exception("Erro no upload: ${e.code}");
    }
  }

  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    return await auth.signInWithCredential(credential);
  }

  registrar(String email, String senha, Uint8List file, String image) async {
    try {
      final response = await auth.createUserWithEmailAndPassword(
          email: email, password: senha);
      getUser();
      image = await uploadImage("profileImage", file);
      UserModel user = UserModel(
        email: email,
        uid: response.user!.uid,
        photoImage: image,
      );

      await fire.collection("users").doc(response.user!.uid).set(user.toJson());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito fraca!');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException('Este email já está cadastrado');
      }
    }
  }

  login(String email, String senha) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: senha);
      getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException('Email não encontrado. Cadastre-se.');
      } else if (e.code == 'wrong-password') {
        throw AuthException('Senha incorreta. Tente novamente');
      }
    }
  }

  logout() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
    getUser();
  }
}
