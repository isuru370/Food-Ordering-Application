
import 'package:flutter/material.dart';
import 'package:food_ordering_application/app_view.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const FoodOrderingApp(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const FoodOrderingApp(),
        );
    }
  }
}
