class Routes {
  const Routes._({required this.name, required this.path});

  final String name;
  final String path;

  static const rootRoute = Routes._(name: 'root', path: '/');

  static const signIn = Routes._(name: 'sign-in', path: '/sign-in');
  static const signUp = Routes._(name: 'sign-up', path: '/sign-up');
  static const home = Routes._(name: 'home', path: '/home');
}
