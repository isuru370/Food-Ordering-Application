import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../../models/menu_model.dart';
import '../../repository/menu/all_food_repo.dart';

class MenuProvider extends ChangeNotifier {
  final AllFoodRepo allFoodRepo;

  bool _isLoading = false;
  String? _errorMessage;
  List<Menu> _menuList = [];

  MenuProvider({required this.allFoodRepo});

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Menu> get menuList => _menuList;

  // Fetch Menus
  Future<void> fetchMenus() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await allFoodRepo.fetchMenus().then(
        (response) {
          final Map<String, dynamic> data = jsonDecode(response);

          if (data['Status'] == true) {
            final List<dynamic> menuJson = data['Result']['Menu'];
            _menuList = menuJson.map((json) => Menu.fromJson(json)).toList();
          } else {
            _errorMessage = 'Failed to load menus: Status is not true';
          }
        },
      );
    } catch (error) {
      _errorMessage = 'Failed to load menus: ${error.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
