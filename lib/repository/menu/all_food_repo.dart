import 'package:flutter/services.dart';
import 'all_food.dart';

class AllFoodRepo implements AllFood {
  @override
  Future<String> fetchMenus() async {
    try {
      final String response =
          await rootBundle.loadString('assets/data/assignment_dataset.json');
      return response;
    } catch (e) {
      throw Exception("Failed to load menus: $e");
    }
  }
}
