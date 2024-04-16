import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class FirebaseAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;


  User? usuario;
  bool isLoading = true;

  FirebaseAuthService(){
    authCheck();
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

  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    return await auth.signInWithCredential(credential);
  }

  registrar(String email, String senha) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: senha);
      getUser();
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
