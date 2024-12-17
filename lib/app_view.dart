import 'package:flutter/material.dart';
import 'package:food_ordering_application/routes/route.dart';

class FoodOrderingApp extends StatelessWidget {
  const FoodOrderingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Ordering App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      initialRoute: '/menu_screen',
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
