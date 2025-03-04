import 'package:equatable/equatable.dart';
import 'package:reactive_forms/reactive_forms.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
  @override
  List<Object?> get props => [];
}

class OnSignUp extends SignUpEvent {
  final FormGroup form;

  const OnSignUp({required this.form});

  @override
  List<Object?> get props => [form];
}
