import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/quantity_provider.dart';
import 'tab_screen/ingredients_tab.dart';
import 'tab_screen/nutritional_tab.dart';

class SingleViewProduct extends StatefulWidget {
  const SingleViewProduct({super.key});

  @override
  State<SingleViewProduct> createState() => _SingleViewProductState();
}

class _SingleViewProductState extends State<SingleViewProduct>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductImage(),
          const SizedBox(height: 10),
          _buildProductDetails(),
          const SizedBox(height: 10),
          _buildTabBar(),
          Expanded(child: _buildTabBarView()),
        ],
      ),
    );
  }

  //  product image
  Widget _buildProductImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/images/product_image.png',
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.height * 0.2,
        ),
      ),
    );
  }

  //product details
  Widget _buildProductDetails() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subway Special',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                '₹1200',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.blueAccent,
              ),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.green, size: 18),
                  SizedBox(width: 5),
                  Text(
                    '5.0',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alterame form, by injected humour, or randomised words which dont look even slightly believable.',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  //  the tab bar
  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      labelColor: Colors.green,
      unselectedLabelColor: Colors.black54,
      indicatorColor: Colors.green,
      indicatorWeight: 3,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
      tabs: const [
        Tab(text: 'Ingredients'),
        Tab(text: 'Nutritional'),
        Tab(text: 'Instructions'),
        Tab(text: 'More'),
      ],
    );
  }

  // tab bar view
  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: const [
        IngredientsTab(),
        NutritionalTab(),
        _InstructionsTab(),
        Center(child: Text("More Details Coming Soon!")),
      ],
    );
  }

  // Bottom Navigation Bar
  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _QuantitySelector(),
          ElevatedButton(
            onPressed: () {
              // Add cart function
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Added to Cart!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'Add to Cart ₹1260',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// Quantity Selector Widget
class _QuantitySelector extends StatelessWidget {
  const _QuantitySelector({super.key});

  @override
  Widget build(BuildContext context) {
    final quantityProvider = Provider.of<QuantityProvider>(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decrement Button
          IconButton(
            onPressed: quantityProvider.decrement,
            icon: const Icon(Icons.remove, color: Colors.black87),
          ),

          // Quantity Display
          Text(
            '${quantityProvider.quantity}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          // Increment Button
          IconButton(
            onPressed: quantityProvider.increment,
            icon: const Icon(Icons.add, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

// Instructions Tab
class _InstructionsTab extends StatelessWidget {
  const _InstructionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'title',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
