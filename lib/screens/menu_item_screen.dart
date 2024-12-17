import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/category_model.dart';
import '../provider/menu_item_bloc/menu_item_provider.dart';
import '../repository/menu/all_food_repo.dart';

class MenuItemScreen extends StatefulWidget {
  final List<MenuEntity>? menuEntities;

  const MenuItemScreen({super.key, required this.menuEntities});

  @override
  State<MenuItemScreen> createState() => _MenuItemScreenState();
}

class _MenuItemScreenState extends State<MenuItemScreen> {
  late MenuItemProvider _menuItemProvider;

  @override
  void initState() {
    super.initState();

    _menuItemProvider = MenuItemProvider(allFoodRepo: AllFoodRepo());

    if (widget.menuEntities != null && widget.menuEntities!.isNotEmpty) {
      _menuItemProvider.fetchMenuItems(widget.menuEntities!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _menuItemProvider,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Menu Items'),
        ),
        body: Consumer<MenuItemProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (provider.errorMessage != null) {
              return Center(
                child: Text(
                  provider.errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            } else if (provider.menuItems.isEmpty) {
              return const Center(
                child: Text(
                  'No items available.',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 3 / 5,
                ),
                itemCount: provider.menuItems.length,
                itemBuilder: (context, index) {
                  final item = provider.menuItems[index];

                  return InkWell(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed('/single_view_product_screen');
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            flex: 2,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12)),
                              child: item.imageURL != null
                                  ? Image.network(
                                      item.imageURL!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    )
                                  : Container(
                                      color: Colors.grey[200],
                                      child: const Center(
                                        child: Icon(Icons.fastfood,
                                            size: 50, color: Colors.grey),
                                      ),
                                    ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    item.title?.en ?? "No Title",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "Price: \$${item.priceInfo?.price?.pickupPrice ?? 'N/A'}",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  ),
                                  if (item.metaData?.isDealProduct ?? false)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: const Text(
                                        "Deal",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed('/modifier_item_screen',
                                        arguments: {
                                      'modifier_item_roles':
                                          item.modifierGroupRules
                                    });
                              },
                              icon: const Icon(Icons.arrow_forward))
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
