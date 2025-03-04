import 'package:firebase_auth/firebase_auth.dart';

abstract class SignUpRepository {
  Future<void> signUp({required String email, required String password});
}

class SignUpRepositoryImpl implements SignUpRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  SignUpRepositoryImpl();

  @override
  Future<void> signUp({required String email, required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
