import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagine_notes/features/auth/sign_in/data/sign_in_repository.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInRepository repository = SignInRepositoryImpl();

  SignInBloc() : super(SignInInitial()) {
    on<OnSignIn>(_onSignInRequested);
    on<OnSignUpPressed>((_, emit) => emit(SignUpNavigate()));
  }

  Future<void> _onSignInRequested(OnSignIn event, Emitter<SignInState> emit) async {
    final form = event.form;

    if (form.valid) {
      emit(SignInLoading());

      final email = form.value['email'] as String;
      final password = form.value['password'] as String;

      try {
        await repository.signIn(email, password);
        emit(SignInSuccess());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          emit(SignInFailure('Correo o contraseña incorrectos'));
        }
      } catch (e) {
        emit(SignInFailure('Ha ocurrido un error inesperado'));
      }
    } else {
      form.markAllAsTouched();
      emit(SignInInvalid());
    }
  }
}
