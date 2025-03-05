import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imagine_notes/core/constants/snackbar.dart';
import 'package:imagine_notes/core/navigation/routes.dart';
import 'package:imagine_notes/features/auth/sign_in/data/sign_in_repository.dart';
import 'package:imagine_notes/features/auth/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:imagine_notes/features/auth/sign_in/presentation/bloc/sign_in_state.dart';
import 'package:imagine_notes/features/auth/sign_in/presentation/widgets/sign_in_form.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInBloc(SignInRepositoryImpl()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: BlocListener<SignInBloc, SignInState>(
              listener: (context, state) {
                if (state is SignUpNavigate) {
                  context.pushNamed(Routes.signUp.name);
                }
                if (state is SignInFailure) {
                  CustomSnackBar.show(context, message: state.error);
                }
                if (state is SignInSuccess) {
                  context.goNamed(Routes.home.name);
                }
              },
              child: SignInForm(),
            ),
          );
        }
      ),
    );
  }
}
