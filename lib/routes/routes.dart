import 'package:flutter/material.dart';
import 'package:projeto_integracao_api/pages/home/home_page.dart';

import 'constant_routes.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
  <String, WidgetBuilder>{
    HOME_PAGE_ROUTE: (_) => const HomePage()
  };

  static String home = HOME_PAGE_ROUTE;
  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
  static NavigatorState to = Routes.navigatorKey!.currentState!;
}
