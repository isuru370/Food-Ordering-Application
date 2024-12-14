import 'package:flutter/services.dart';
import 'menu_repo.dart';

class MenuRepoData implements MenuRepo {
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
