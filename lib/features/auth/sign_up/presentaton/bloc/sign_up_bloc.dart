import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagine_notes/features/auth/sign_up/data/sign_up_repository.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpRepository repository;

  SignUpBloc(this.repository) : super(SignUpInitial()) {
    on<OnSignUp>(_onSignUp);
  }

  Future<void> _onSignUp(OnSignUp event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());
    final form = event.form;
    if (!form.valid) {
      form.markAllAsTouched();
      emit(SignUpInvalid());
      return;
    }

    final email = form.control('email').value as String;
    final password = form.control('password').value as String;
    final confirmPassword = form.control('confirmPassword').value as String;

    if (password != confirmPassword) {
      emit(const SignUpFailure("Las contraseñas no coinciden."));
      return;
    }
    try {
      await repository.signUp(email: email, password: password);
      emit(SignUpSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(SignUpFailure('El correo ya está en uso.'));
      }
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }
}
