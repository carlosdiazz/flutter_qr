import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr/config/config.dart';
import 'package:qr/src/src.dart';

final appRputerProvider = Provider<GoRouter>((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: "/${NamesRouter.checkAuthScreen}",
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
        path: "/${NamesRouter.checkAuthScreen}",
        name: NamesRouter.checkAuthScreen,
        builder: (context, state) => const CheckAuthScreen(),
      ),
      GoRoute(
        path: "/${NamesRouter.homeScreen}",
        name: NamesRouter.homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: "/${NamesRouter.itemsScreen}",
        name: NamesRouter.itemsScreen,
        builder: (context, state) => const ItemsScreen(),
      ),
      GoRoute(
        path: "/${NamesRouter.loginScreen}",
        name: NamesRouter.loginScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: "/${NamesRouter.registerScreen}",
        name: NamesRouter.registerScreen,
        builder: (context, state) => const RegisterScreen(),
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;
      final authStatus = goRouterNotifier.authStatus;

      if (isGoingTo == "/${NamesRouter.checkAuthScreen}" &&
          authStatus == AuthStatus.checking) {
        return null;
      }

      if (authStatus == AuthStatus.notAuthenticated) {
        return "/${NamesRouter.loginScreen}";
      }
      if (authStatus == AuthStatus.authenticated) {
        return "/${NamesRouter.homeScreen}";
      }

      return isGoingTo;
    },
  );
});
