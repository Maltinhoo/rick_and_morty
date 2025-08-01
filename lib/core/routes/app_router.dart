import 'package:rick_and_morty/app_imports.dart';

class GoRouterSystem {
  const GoRouterSystem._();

  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  static final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');
  static final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  static BuildContext? get ctx =>
      router.routerDelegate.navigatorKey.currentContext;

  static const String initialRoutePath = SplashPage.name;

  static GoRouter router = GoRouter(
    initialLocation: initialRoutePath,
    debugLogDiagnostics: kDebugMode,
    navigatorKey: rootNavigatorKey,
    routes: [
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: SplashPage.name,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: HomePage.name,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: CharacterPage.name,
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          return CharacterPage(char: args?['char']);
        },
      ),

      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: FiltersPage.name,
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          return FiltersPage(
            selectedGender: args?['selectedGender'],
            selectedSpecies: args?['selectedSpecies'],
            selectedStatus: args?['selectedStatus'],
          );
        },
      ),
    ],
  );
}
