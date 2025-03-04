import 'package:firebase_auth/firebase_auth.dart';

abstract class SignInRepository {
  Future<void> signIn(String email, String password);
}

class SignInRepositoryImpl implements SignInRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  SignInRepositoryImpl();

  @override
  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
