import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/category_bloc/category_provider.dart';
import '../repository/menu/all_food_repo.dart';

class CategoryScreen extends StatefulWidget {
  final List<String>? menuCategoryIDs;

  const CategoryScreen({super.key, required this.menuCategoryIDs});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late CategoryProvider _categoryProvider;

  @override
  void initState() {
    super.initState();

    // Initialize CategoryProvider
    _categoryProvider = CategoryProvider(allFoodRepo: AllFoodRepo());

    // Fetch categories for the provided menuCategoryIDs
    if (widget.menuCategoryIDs != null && widget.menuCategoryIDs!.isNotEmpty) {
      _categoryProvider.fetchCategories(widget.menuCategoryIDs!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _categoryProvider,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
        ),
        body: Consumer<CategoryProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (provider.errorMessage != null) {
              return Center(
                child: Text(
                  'Error: ${provider.errorMessage}',
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            } else if (provider.categories.isEmpty) {
              return const Center(
                child: Text(
                  'No categories available.',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: provider.categories.length,
              itemBuilder: (context, index) {
                final category = provider.categories[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.restaurant_outlined),
                    ),
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      category.title?.en ?? 'Untitled Category',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      category.subTitle?.en ?? 'No subtitle available',
                      style: const TextStyle(fontSize: 14),
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pushNamed(
                        '/menu_item_screen',
                        arguments: {
                          'menu_entities': category.menuEntities, // Pass List<String>
                        },
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
