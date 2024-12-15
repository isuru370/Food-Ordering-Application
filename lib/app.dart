import 'package:flutter/material.dart';
import 'package:food_ordering_application/provider/modifier_provider.dart';
import 'package:provider/provider.dart';

import 'app_view.dart';
import 'provider/category_bloc/category_provider.dart';
import 'provider/menu_item_bloc/menu_item_provider.dart';
import 'provider/menu_provider/menu_provider.dart';
import 'repository/menu/all_food_repo.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => MenuProvider(allFoodRepo: AllFoodRepo()),
      ),
      ChangeNotifierProvider(
        create: (_) => CategoryProvider(allFoodRepo: AllFoodRepo()),
      ),
      ChangeNotifierProvider(
        create: (_) => MenuItemProvider(allFoodRepo: AllFoodRepo()),
      ),
      ChangeNotifierProvider(
        create: (_) => ModifierProvider(allFoodRepo: AllFoodRepo()),
      ),
    ], child: const FoodOrderingApp());
  }
}
