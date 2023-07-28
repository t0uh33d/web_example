import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:routing_example/base_screen.dart';
import 'package:routing_example/web_initializer.dart';

typedef RouterKey = GlobalKey<NavigatorState>?;

class AppRouter {
  static final AppRouter _appRouter = AppRouter._internal();

  factory AppRouter() {
    return _appRouter;
  }

  AppRouter._internal();

  late GoRouter goRouter;
  late RouterKey _rootNavigatorKey;

  RouterKey get routerRootKey => _rootNavigatorKey;

  BuildContext get currentContext => _rootNavigatorKey!.currentContext!;

  void init() {
    _rootNavigatorKey = GlobalKey<NavigatorState>();
    goRouter = GoRouter(
      initialLocation: '/',
      navigatorKey: _rootNavigatorKey,
      routes: _routes,
      errorBuilder: (context, state) => const WebInitializer(),
      redirect: (context, state) async {
        // return await Authenticator().urlPahtBasedAuthRedirection(state);
      },
    );
  }

  /// list of routes for the go router
  List<RouteBase> get _routes {
    return <RouteBase>[
      /// default route - we will send the user to [WebInitializer]
      GoRoute(
        path: '/',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const WebInitializer(),
      ),

      /// we dynamically match the patter of the url and get the variable value
      GoRoute(
        path: '/:activeNavOption',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          /// the matched value will be  extracted here
          String? activeNavOption = state.pathParameters['activeNavOption'];

          /// the {activeNavOption} is basically the current active naviagtion item
          /// we need to pass this to our main screen because dxshellcontroller needs it to know
          /// which item is active
          return BaseScreen(
            activeNode: activeNavOption,
          );
        },
      ),
    ];
  }
}
