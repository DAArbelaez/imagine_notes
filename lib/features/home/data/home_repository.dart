import 'package:firebase_auth/firebase_auth.dart';

abstract class HomeRepository {
  Future<void> logout();
}

class HomeRepositoryImpl implements HomeRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  HomeRepositoryImpl();

  @override
  Future<void> logout() async => await _firebaseAuth.signOut();
}
