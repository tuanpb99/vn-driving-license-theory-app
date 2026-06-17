import 'package:flutter/material.dart';

import 'app_routes.dart';

class AppTabNavigation {
  const AppTabNavigation._();

  static void openTab(BuildContext context, int index, int currentIndex) {
    if (index == currentIndex) return;

    final route = switch (index) {
      0 => AppRoutes.home,
      1 => AppRoutes.training,
      2 => AppRoutes.info,
      _ => AppRoutes.home,
    };

    Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
  }
}
