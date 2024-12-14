import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ordering_application/app_view.dart';
import 'package:food_ordering_application/repository/menu/menu_repo_data.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider<MenuRepoData>(create: (_) => MenuRepoData()),
    ], child: const FoodOrderingApp());
  }
}
