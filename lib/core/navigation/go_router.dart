import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imagine_notes/core/navigation/routes.dart';
import 'package:imagine_notes/features/auth/sign_in/presentation/sign_in_page.dart';
import 'package:imagine_notes/features/auth/sign_up/presentaton/sign_up_page.dart';
import 'package:imagine_notes/features/home/presentation/home_page.dart';
import 'package:imagine_notes/features/splash/presentation/splash_page.dart';

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
            child: const SplashPage(),
            state: state,
          );
        },
      ),
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
      GoRoute(
        path: Routes.signUp.path,
        name: Routes.signUp.name,
        pageBuilder: (_, state) {
          return _getPage(
            child: SignUpPage(),
            state: state,
          );
        },
      ),
      GoRoute(
        path: Routes.home.path,
        name: Routes.home.name,
        pageBuilder: (_, state) {
          return _getPage(
            child: const HomePage(),
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
