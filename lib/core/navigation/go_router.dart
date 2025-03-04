import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imagine_notes/core/navigation/routes.dart';
import 'package:imagine_notes/features/auth/sign_in/sign_in_page.dart';
import 'package:imagine_notes/features/splash/bloc/splash_bloc.dart';
import 'package:imagine_notes/features/splash/bloc/splash_event.dart';
import 'package:imagine_notes/features/splash/splash_page.dart';

class GoRouterHelper {
  static final GoRouterHelper _instance = GoRouterHelper._internal();

  factory GoRouterHelper() => _instance;

  late final GoRouter router;

  GoRouterHelper._internal() {
    var routes = [
      GoRoute(
        path: Routes.rootRoute.path,
        name: Routes.rootRoute.name,
        pageBuilder: (_, state) {
          return _getPage(
            child: BlocProvider(
              create: (_) => SplashBloc()..add(SplashStarted()),
              child: const SplashPage(),
            ),
            state: state,
          );
        },
      ),
      // Admin routes
      GoRoute(
        path: Routes.signIn.path,
        name: Routes.signIn.name,
        pageBuilder: (_, state) {
          return _getPage(
            child: const SignInPage(),
            state: state,
          );
        },
      ),
    ];

    router = GoRouter(
      debugLogDiagnostics: true,
      initialLocation: Routes.rootRoute.path,
      routes: routes,
    );
  }

  Page _getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }
}
