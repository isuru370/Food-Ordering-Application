import 'package:flutter/material.dart';
import 'package:food_ordering_application/screens/menu_screen.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const MenuScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const MenuScreen(),
        );
    }
  }
}
