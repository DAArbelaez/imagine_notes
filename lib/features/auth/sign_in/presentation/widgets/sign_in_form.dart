import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagine_notes/core/constants/text_styles.dart';
import 'package:imagine_notes/features/auth/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:imagine_notes/features/auth/sign_in/presentation/bloc/sign_in_event.dart';
import 'package:imagine_notes/features/common/presentation/buttons/custom_button.dart';
import 'package:imagine_notes/features/common/presentation/text_field/custom_reactive_textfield.dart';
import 'package:imagine_notes/features/common/presentation/text_field/password_reactive_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignInForm extends StatelessWidget {
  SignInForm({super.key});

  final FormGroup form = FormGroup({
    'email': FormControl<String>(validators: [Validators.required, Validators.email]),
    'password': FormControl<String>(validators: [Validators.required, Validators.minLength(6)]),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ReactiveForm(
        formGroup: form,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Imagine Notes', style: AppTextStyle.headlineSmall),
              const SizedBox(height: 32),
              CustomReactiveTextField(
                formControlName: 'email',
                label: 'Correo electrónico',
                keyboardType: TextInputType.emailAddress,
                validationMessages: {
                  ValidationMessage.required: (_) => 'El correo es obligatorio',
                  ValidationMessage.email: (_) => 'Ingresa un correo válido',
                },
              ),
              const SizedBox(height: 16),
              PasswordReactiveField(
                formControlName: 'password',
                label: 'Contraseña',
                validationMessages: {
                  ValidationMessage.required: (_) => 'La contraseña es obligatoria',
                  ValidationMessage.minLength: (_) => 'Debes ingresar al menos 6 caracteres',
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: CustomButton.primary(
                  text: 'Iniciar sesión',
                  onPressed: () => context.read<SignInBloc>().add(OnSignIn(form: form)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: CustomButton.secondary(
                  text: 'Registrarse',
                  onPressed: () => context.read<SignInBloc>().add(OnSignUpPressed()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
