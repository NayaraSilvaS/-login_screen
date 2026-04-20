import 'package:flutter/material.dart';
import 'package:login_screen/presentation/pages/home_page.dart';
import 'package:login_screen/presentation/pages/login_page.dart';
import 'package:login_screen/presentation/pages/stats_page.dart';
import 'package:login_screen/presentation/stores/item_store.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (_) => LoginPage(),
    '/home': (_) => HomePage(),

    '/stats': (context) {
      final store =
          ModalRoute.of(context)!.settings.arguments as ItemStore;

      return StatsPage(store: store);
    },
  };
}
