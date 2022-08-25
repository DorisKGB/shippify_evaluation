import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/error/v_error.dart';
import '../pages/device/bloc/p_device.dart';
import '../utils/service_locator.dart';
import 'pages.dart';


class MyRouter {
  MyRouter._internal();

  static final MyRouter instance = MyRouter._internal();

  late final router = GoRouter(
    initialLocation: Pages.signUp.getPath(),
    routes: [
      GoRoute(
        name: Pages.signUp.getKey(),
        path: Pages.signUp.getPath(),
        builder: (BuildContext context, GoRouterState state) => PDevice(          
          bloc: () => ServiceLocator.instance.bSignUp(),
        ),
      ),
    ],
    errorBuilder: (BuildContext context, GoRouterState state) =>
        VError(error: state.error.toString()),
  );
}