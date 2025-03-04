import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imagine_notes/core/constants/snackbar.dart';
import 'package:imagine_notes/core/navigation/routes.dart';
import 'package:imagine_notes/features/common/presentation/buttons/custom_button.dart';
import 'package:imagine_notes/features/home/presentation/bloc/home_bloc.dart';
import 'package:imagine_notes/features/home/presentation/bloc/home_event.dart';
import 'package:imagine_notes/features/home/presentation/bloc/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: Builder(
        builder: (context) {
          return BlocListener<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is HomeLogoutSuccess) {
                context.goNamed(Routes.signIn.name);
              }
              if (state is HomeLogoutFailure) {
                CustomSnackBar.show(context, message: state.error);
              }
            },
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Home Page'),
              ),
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Bienvenido a Home Page'),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: 200,
                      child: CustomButton.secondary(
                        text: 'Cerrar sesión',
                        onPressed: () => context.read<HomeBloc>().add(HomeLogoutRequested()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
