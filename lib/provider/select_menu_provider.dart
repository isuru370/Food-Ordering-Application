import 'package:flutter/material.dart';

class SelectMenuProvider extends ChangeNotifier {
  String _selectedMenu = "Lunch";

  String get selectedMenu => _selectedMenu;

  void updateMenu(String menu) {
    _selectedMenu = menu;
    notifyListeners();
  }
}
