import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../models/category_model.dart';
import '../../models/item_model.dart';
import '../../repository/menu/all_food_repo.dart';

class MenuItemProvider extends ChangeNotifier {
  final AllFoodRepo allFoodRepo;

  // State variables
  bool _isLoading = false;
  List<MenuItem> _menuItems = [];
  String? _errorMessage;

  MenuItemProvider({required this.allFoodRepo});

  bool get isLoading => _isLoading;
  List<MenuItem> get menuItems => _menuItems;
  String? get errorMessage => _errorMessage;

  Future<void> fetchMenuItems(List<MenuEntity> menuEntities) async {
    _isLoading = true;
    _errorMessage = null;
    _menuItems = [];
    notifyListeners();

    try {
      final menuItemResponse = await allFoodRepo.fetchMenus();
      final Map<String, dynamic> data = jsonDecode(menuItemResponse);

      if (data['Status'] == true) {
        final List<dynamic>? menuItemJson = data['Result']?['Items'];

        if (menuItemJson == null) {
          _errorMessage = 'No items found in response.';
          _isLoading = false;
          notifyListeners();
          return;
        }

        final List<String> menuEntityIDs =
            menuEntities.map((entity) => entity.id!).toList();

        final List<MenuItem> matchingMenuItems = menuItemJson
            .where((json) => menuEntityIDs.contains(json['MenuItemID']))
            .map((json) => MenuItem.fromJson(json))
            .toList();

        if (matchingMenuItems.isNotEmpty) {
          _menuItems = matchingMenuItems;
        } else {
          _errorMessage = 'No matching menu items found.';
        }
      } else {
        _errorMessage = 'Failed to load items: Status false.';
      }
    } catch (e) {
      log(e.toString());
      _errorMessage = "An error occurred: ${e.toString()}";
    }

    _isLoading = false;
    notifyListeners();
  }
}
