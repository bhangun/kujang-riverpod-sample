import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'apps_routes.dart';


class GoRoutesService {
  static final GoRoutesService _singleton = GoRoutesService._();
  GoRoutesService._();

  factory GoRoutesService() => _singleton;

  static final Map<String, Widget Function(BuildContext)> _routes = <String, WidgetBuilder>{};

  static Future<GoRoutesService> get instance async{ 
    _routes.addAll(AppsRoutes.routes);
    return _singleton;
  }

  static get routes => _routes;

  static addRoutes(Map<String, Widget Function(BuildContext)> newRoutes) {
    _routes.addAll(newRoutes);
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Text('');
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return const Text('');
          },
        ),
      ],
    ),
  ],
);