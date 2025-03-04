import 'package:equatable/equatable.dart';
import 'package:reactive_forms/reactive_forms.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class OnSignIn extends SignInEvent {
  final FormGroup form;

  const OnSignIn({required this.form});

  @override
  List<Object> get props => [form];
}


class OnSignUpPressed extends SignInEvent {}