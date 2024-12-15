import 'package:flutter/material.dart';
import 'package:food_ordering_application/screens/category_screen.dart';
import 'package:food_ordering_application/screens/menu_screen.dart';
import 'package:food_ordering_application/screens/modifier_screen.dart';

import '../models/category_model.dart';
import '../models/item_model.dart';
import '../screens/menu_item_screen.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const MenuScreen(),
        );
      case '/category_screen':
        final args = setting.arguments as Map<String, dynamic>;
        final menuCategoryIDs = args['menuCategoryIDs'] as List<String>?;
        return MaterialPageRoute(
          builder: (context) => CategoryScreen(
            menuCategoryIDs: menuCategoryIDs,
            // Ensure null safety
          ),
        );
      case '/menu_item_screen':
        final args = setting.arguments as Map<String, dynamic>;
        final menuEntities = args['menu_entities'] as List<MenuEntity>?;
        return MaterialPageRoute(
          builder: (context) => MenuItemScreen(
            menuEntities: menuEntities,
          ),
        );
      case '/modifier_item_screen':
        final args = setting.arguments as Map<String, dynamic>;
        final modifierGroupRules =
            args['modifier_item_roles'] as ModifierGroupRules;
        return MaterialPageRoute(
          builder: (context) => ModifierScreen(
            modifierGroupRules: modifierGroupRules,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const MenuScreen(),
        );
    }
  }
}
