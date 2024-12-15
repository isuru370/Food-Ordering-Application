import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_ordering_application/repository/menu/all_food_repo.dart';
import '../models/item_model.dart';
import '../models/modifier_group_model.dart';

class ModifierProvider extends ChangeNotifier {
  final AllFoodRepo allFoodRepo;

  bool _isLoading = false;
  String? _errorMessage;
  List<ModifierGroup> _modifierList = [];
  Map<String, bool> _selectedModifierGroups =
      {}; // This will store selected states

  ModifierProvider({required this.allFoodRepo});

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<ModifierGroup> get modifierList => _modifierList;
  Map<String, bool> get selectedModifierGroups => _selectedModifierGroups;

  Future<void> fetchModifier(
      ModifierGroupRules modifierGroupRules) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await allFoodRepo.fetchMenus().then((response) {
        final Map<String, dynamic> data = jsonDecode(response);

        if (data['Status'] == true) {
          final List<dynamic>? modifierItemJson =
              data['Result']?['ModifierGroups'];

          if (modifierItemJson == null) {
            _errorMessage = 'No items found in response.';
            _isLoading = false;
            notifyListeners();
            return;
          }

          // Handle null 'ids' and default to an empty list if it's null
          final List<String> menuEntityIDs = modifierGroupRules.ids ?? [];

          // Filter modifiers based on the menuEntityIDs
          final List<ModifierGroup> modifiersItem = modifierItemJson
              .where((json) => menuEntityIDs.contains(json['ModifierGroupID']))
              .map((json) => ModifierGroup.fromJson(json))
              .toList();

          if (modifiersItem.isNotEmpty) {
            _modifierList = modifiersItem;
            // Initialize selection state for each modifier group.
            for (var group in _modifierList) {
              _selectedModifierGroups[group.modifierGroupID.toString()] =
                  false; // Initially not selected
            }
          } else {
            _errorMessage = 'No matching menu items found.';
          }
        }
        _isLoading = false;
        notifyListeners();
      });
    } catch (error) {
      _errorMessage = error.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Method to update the selection of a modifier group
  void updateSelection(String modifierGroupID, bool selected) {
    _selectedModifierGroups[modifierGroupID] = selected;
    notifyListeners();
  }
}
