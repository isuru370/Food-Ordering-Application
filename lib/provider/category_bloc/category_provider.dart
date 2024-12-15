import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../../models/category_model.dart';
import '../../repository/menu/all_food_repo.dart';

class CategoryProvider extends ChangeNotifier {
  final AllFoodRepo allFoodRepo;

  // State variables
  bool _isLoading = false;
  List<Category> _categories = [];
  String? _errorMessage;

  CategoryProvider({required this.allFoodRepo});

  bool get isLoading => _isLoading;
  List<Category> get categories => _categories;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCategories(List<String> menuCategoryIDs) async {
    _isLoading = true;
    _errorMessage = null;
    _categories = [];
    notifyListeners();

    try {
      // Fetch data from repository
      final responseMenu = await allFoodRepo.fetchMenus();
      final Map<String, dynamic> data = jsonDecode(responseMenu);

      if (data['Status'] == true) {
        final List<dynamic>? menuJson = data['Result']?['Categories'];

        if (menuJson == null) {
          _errorMessage = 'No categories found in response.';
          _isLoading = false;
          notifyListeners();
          return;
        }

        // Filter categories based on the provided IDs
        final List<Category> matchingCategories = menuJson
            .where((json) => menuCategoryIDs.contains(
                json['MenuCategoryID']?.toString())) // Check if ID is in list
            .map((json) => Category.fromJson(json))
            .toList();

        if (matchingCategories.isNotEmpty) {
          _categories = matchingCategories;
        } else {
          _errorMessage = 'No matching categories found.';
        }
      } else {
        _errorMessage = 'Failed to load categories: Status false.';
      }
    } catch (error) {
      log('Error: ${error.toString()}');
      _errorMessage = 'An error occurred: ${error.toString()}';
    }

    _isLoading = false;
    notifyListeners();
  }
}
