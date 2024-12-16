import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // INISIALISASI FIREBASE AUTHENTICATION
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // LOGIN METHOD
  Future<UserCredential> signInWithEmailAndPassword(
      String email, password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    }
    // MENANGKAP ERROR
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // LOGOUT METHOD
  Future<void> signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
