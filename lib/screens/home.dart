import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_application/components/custom_button.dart';
import 'package:food_ordering_application/provider/select_menu_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderSection(),
          const SizedBox(height: 40),
          _buildBodySection(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  // Header section
  Widget _buildHeaderSection() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildHeaderImage(),
        _buildBackButton(),
        _buildTitleAndSubtitle(),
        _buildTabBar(),
      ],
    );
  }

  // Header Image
  Widget _buildHeaderImage() {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/header_image.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _buildBackButton() {
    return Positioned(
      top: 10,
      left: 10,
      right: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                //back button
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ],
      ),
    );
  }

  // Title and subtitle
  Widget _buildTitleAndSubtitle() {
    return const Positioned(
      bottom: 50,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'El Cabanyal',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'FASTFOOD · BURGERS',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/logo.png'),
          ),
        ],
      ),
    );
  }

  // Tab bar with icons
  Widget _buildTabBar() {
    return Positioned(
      bottom: -30,
      left: 30,
      right: 30,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _iconTab(Icons.directions_bike, false),
              _iconTab(Icons.local_grocery_store, true),
              _iconTab(Icons.map, false),
            ],
          ),
        ),
      ),
    );
  }

  // Filter and dropdown menu section
  Widget _buildBodySection() {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdownAndSearch(),
              const SizedBox(height: 20),
              _buildFilterChips(),
              const SizedBox(height: 15),
              _buildProductList('SANDWICHES'),
              const SizedBox(height: 10),
              _buildProductList('BURGERS'),
            ],
          ),
        ),
      ),
    );
  }

  // Dropdown menu and search icon
  Widget _buildDropdownAndSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          _buildDropdownMenu(),
          IconButton(
            icon: const Icon(Icons.search, size: 30),
            onPressed: () {
              // Add your search logic
            },
          ),
        ],
      ),
    );
  }

  // Dropdown menu widget
  Widget _buildDropdownMenu() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none,
            ),
          ),
          dropdownColor: Colors.white,
          value: 'Lunch Menu',
          items: const [
            DropdownMenuItem(
              value: 'Lunch Menu',
              child: Text(
                'LUNCH MENU',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            DropdownMenuItem(
              value: 'Dinner Menu',
              child: Text(
                'DINNER MENU',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
          ],
          onChanged: (value) {},
        ),
      ),
    );
  }

  // Filter Chips widget
  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: 40,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: const [
            _FilterChip(label: 'Basic', selected: true),
            _FilterChip(label: 'Sandwiches'),
            _FilterChip(label: 'Burgers'),
            _FilterChip(label: 'Pizza'),
            _FilterChip(label: 'Sandwiches'),
            _FilterChip(label: 'Burgers'),
            _FilterChip(label: 'Pizza'),
          ],
        ),
      ),
    );
  }

  // Product list section
  Widget _buildProductList(String category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            category,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 500,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => _buildBottomSheet(),
                  );
                },
                child: _buildProductRow(),
              );
            },
          ),
        ),
      ],
    );
  }

// Method to create an icon tab
  Widget _iconTab(IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () {
        // Handle tab click logic
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 30,
            color: isSelected ? Colors.blue : Colors.black54,
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 5),
              width: 10,
              height: 3,
              color: Colors.blue,
            ),
        ],
      ),
    );
  }

  // Product row widget
  Widget _buildProductRow() {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProductImage(),
          const SizedBox(width: 12),
          Expanded(child: _ProductDetails()),
        ],
      ),
    );
  }

  // Bottom navigation bar widget
  Widget _buildBottomNavigation() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              CustomButton(
                  onPressed: () {}, buttonText: "Basket • 3 items • £24.00"),
              CustomButton(onPressed: () {}, buttonText: "view basket"),
            ],
          ),
        ),
      ],
    );
  }

  // Product image widget
  Widget _ProductImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        'assets/images/item_image.png',
        width: 80,
        height: 80,
        fit: BoxFit.cover,
      ),
    );
  }

  // Product details widget
  Widget _ProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Product Name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 4),
        const Text("Product Description",
            style: TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 8),
        _PriceAndAvailability(),
      ],
    );
  }

  // Price and availability widget
  Widget _PriceAndAvailability() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("\$ Price",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        Card(
          color: Colors.orange,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Text(
              "2 Promotion Available",
              style: TextStyle(fontSize: 12, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  // Bottom sheet widget
  Widget _buildBottomSheet() {
    return Consumer<SelectMenuProvider>(
      builder: (context, selectMenu, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Select Menu",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildRadioButtons(selectMenu),
              const SizedBox(height: 16),
              CustomButton(onPressed: () {}, buttonText: "Done"),
            ],
          ),
        );
      },
    );
  }

  // Radio buttons for selecting menu
  Widget _buildRadioButtons(SelectMenuProvider selectMenu) {
    return Column(
      children: [
        RadioListTile<String>(
          title: const Text("Lunch 10AM - 5PM"),
          value: "Lunch",
          groupValue: selectMenu.selectedMenu,
          onChanged: (value) {
            if (value != null) {
              selectMenu.updateMenu(value);
            }
          },
        ),
        RadioListTile<String>(
          title: const Text("Breakfast 5PM - 11PM"),
          value: "Breakfast",
          groupValue: selectMenu.selectedMenu,
          onChanged: (value) {
            if (value != null) {
              selectMenu.updateMenu(value);
            }
          },
        ),
      ],
    );
  }
}

// Custom filter chip widget
class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;

  const _FilterChip({Key? key, required this.label, this.selected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
