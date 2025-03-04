import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imagine_notes/core/constants/snackbar.dart';
import 'package:imagine_notes/core/navigation/routes.dart';
import 'package:imagine_notes/features/auth/sign_up/presentaton/bloc/sign_up_bloc.dart';
import 'package:imagine_notes/features/auth/sign_up/presentaton/bloc/sign_up_event.dart';
import 'package:imagine_notes/features/auth/sign_up/presentaton/bloc/sign_up_state.dart';
import 'package:imagine_notes/features/common/presentation/buttons/custom_button.dart';
import 'package:imagine_notes/features/common/presentation/text_field/custom_reactive_input.dart';
import 'package:imagine_notes/features/common/presentation/text_field/password_reactive_input.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:imagine_notes/core/constants/text_styles.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final FormGroup form = FormGroup(
    {
      'email': FormControl<String>(validators: [Validators.required, Validators.email]),
      'password': FormControl<String>(validators: [Validators.required, Validators.minLength(6)]),
      'confirmPassword': FormControl<String>(validators: [Validators.required]),
    },
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Registrarse", style: AppTextStyle.titleMedium),
            ),
            body: BlocListener<SignUpBloc, SignUpState>(
              listener: (context, state) {
                if (state is SignUpFailure) {
                  CustomSnackBar.show(context, message: state.error);
                }
                if (state is SignUpSuccess) {
                  context.goNamed(Routes.signIn.name);
                }
              },
              child: Center(
                child: SingleChildScrollView(
                  child: ReactiveForm(
                    formGroup: form,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Crear Cuenta', style: AppTextStyle.headlineSmall),
                          const SizedBox(height: 32),
                          CustomReactiveInput(
                            formControlName: 'email',
                            label: 'Correo electrónico',
                            keyboardType: TextInputType.emailAddress,
                            validationMessages: {
                              ValidationMessage.required: (_) => 'Este campo es obligatorio',
                              ValidationMessage.email: (_) => 'Ingresa un correo válido',
                            },
                          ),
                          const SizedBox(height: 16),
                          PasswordReactiveInput(
                            formControlName: 'password',
                            label: 'Contraseña',
                            validationMessages: {
                              ValidationMessage.required: (_) => 'Este campo es obligatorio',
                              ValidationMessage.minLength: (_) => 'Debe tener al menos 6 caracteres',
                            },
                          ),
                          const SizedBox(height: 16),
                          PasswordReactiveInput(
                            formControlName: 'confirmPassword',
                            label: 'Confirmar contraseña',
                            validationMessages: {
                              ValidationMessage.required: (_) => 'Este campo es obligatorio',
                              'mustMatch': (_) => 'Las contraseñas no coinciden',
                            },
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: CustomButton.primary(
                              text: 'Registrarse',
                              onPressed: () => context.read<SignUpBloc>().add(OnSignUp(form: form)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
