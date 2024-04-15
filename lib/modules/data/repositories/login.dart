// import 'package:firebase_auth/firebase_auth.dart';

// Future<void> signInWithGoogle() async {
//     AppConfig.isWeb ? signInWithGoogleWeb() : signInWithGoogleApp();
//   }

//   Future<void> signInWithGoogleWeb() async {
//     emit(SignInLoading(method: SignInMethod.google));
//     GoogleAuthProvider googleProvider = GoogleAuthProvider();
//     googleProvider.addScope('email');
//     googleProvider.addScope('profile');
//     googleProvider.setCustomParameters({'prompt': 'select_account'});
//     try {
//       final userCredential = await authService.signInWithPopup(googleProvider);
//       emit(SignInSuccess(credential: userCredential));
//     } on FirebaseAuthException catch (e) {
//       emit(SignInException(exception: e));
//     }
//   }

//   Future<void> signInWithGoogleApp() async {
//     emit(SignInLoading(method: SignInMethod.google));
//     final googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
//     if (await googleSignIn.isSignedIn()) {
//       await googleSignIn.signOut();
//     }
//     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//     if (googleUser == null) {
//       emit(SignInInitial());
//       return;
//     }
//     final googleAuth = await googleUser.authentication;
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//     try {
//       final userCredential = await authService.signInWithCredential(credential);
//       emit(SignInSuccess(credential: userCredential));
//     } on FirebaseAuthException catch (e) {
//       emit(SignInException(exception: e));
//     }
//   }