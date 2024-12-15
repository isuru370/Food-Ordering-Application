import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/menu_model.dart';
import '../provider/menu_provider/menu_provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch menus after the widget is fully built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final menuProvider = Provider.of<MenuProvider>(context, listen: false);
      menuProvider.fetchMenus();
    });
  }

  String _getCurrentDayField() {
    final days = [
      'sunday',
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday'
    ];
    final now = DateTime.now();
    return days[now.weekday % 7];
  }

  String? _getAvailabilityForToday(MenuAvailability? availability) {
    if (availability == null) return null;

    final currentDayField = _getCurrentDayField();
    switch (currentDayField) {
      case 'monday':
        return '${availability.monday?.startTime ?? 'N/A'} - ${availability.monday?.endTime ?? 'N/A'}';
      case 'tuesday':
        return '${availability.tuesday?.startTime ?? 'N/A'} - ${availability.tuesday?.endTime ?? 'N/A'}';
      case 'wednesday':
        return '${availability.wednesday?.startTime ?? 'N/A'} - ${availability.wednesday?.endTime ?? 'N/A'}';
      case 'thursday':
        return '${availability.thursday?.startTime ?? 'N/A'} - ${availability.thursday?.endTime ?? 'N/A'}';
      case 'friday':
        return '${availability.friday?.startTime ?? 'N/A'} - ${availability.friday?.endTime ?? 'N/A'}';
      case 'saturday':
        return '${availability.saturday?.startTime ?? 'N/A'} - ${availability.saturday?.endTime ?? 'N/A'}';
      case 'sunday':
        return '${availability.sunday?.startTime ?? 'N/A'} - ${availability.sunday?.endTime ?? 'N/A'}';
      default:
        return 'Not Available';
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text('Menu', style: TextStyle(fontSize: 24)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // search functionality if needed
            },
          ),
        ],
      ),
      body: menuProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : menuProvider.errorMessage != null
              ? Center(
                  child: Text(
                    'Error: ${menuProvider.errorMessage}',
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                )
              : menuProvider.menuList.isEmpty
                  ? const Center(
                      child: Text('No menus available.',
                          style: TextStyle(fontSize: 18)),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: menuProvider.menuList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 3 / 2.5,
                      ),
                      itemBuilder: (context, index) {
                        final menu = menuProvider.menuList[index];
                        final availability = _getAvailabilityForToday(
                          menu.menuAvailability,
                        );

                        return Card(
                          elevation: 4,
                          child: InkWell(
                            onTap: () {
                              // Navigate to Category Screen
                              Navigator.of(context, rootNavigator: true)
                                  .pushNamed(
                                '/category_screen',
                                arguments: {
                                  'menuCategoryIDs': menu.menuCategoryIDs,
                                },
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const CircleAvatar(
                                  child: Icon(Icons.restaurant_menu),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  menu.title?.en ?? 'Untitled Menu',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  availability != null
                                      ? 'Available today: $availability'
                                      : 'No availability data',
                                  style: const TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
