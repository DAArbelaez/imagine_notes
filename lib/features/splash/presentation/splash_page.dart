import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imagine_notes/core/constants/icons.dart';
import 'package:imagine_notes/core/constants/palette.dart';
import 'package:imagine_notes/core/constants/text_styles.dart';
import 'package:imagine_notes/core/navigation/routes.dart';
import 'package:imagine_notes/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:imagine_notes/features/splash/presentation/bloc/splash_event.dart';
import 'package:imagine_notes/features/splash/presentation/bloc/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc()..add(SplashStarted()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateToSignIn) {
            context.goNamed(Routes.signIn.name);
          }
          if (state is SplashNavigateToHome) {
            context.goNamed(Routes.home.name);
          }
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Palette.primary,
            body: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcons.note,
                SizedBox(height: 10),
                Text(
                  'Imagine Notes',
                  style: AppTextStyle.headlineSmall.copyWith(
                    color: Palette.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                CircularProgressIndicator(color: Palette.white),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
