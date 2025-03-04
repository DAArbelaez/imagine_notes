class Routes {
  const Routes._({required this.name, required this.path});

  final String name;
  final String path;

  static const rootRoute = Routes._(name: 'root', path: '/');

  static const signIn = Routes._(name: 'sign-in', path: '/sign-in');
}
