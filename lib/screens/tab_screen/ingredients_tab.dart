import 'package:flutter/material.dart';


class IngredientsTab extends StatefulWidget {
  const IngredientsTab({super.key});

  @override
  State<IngredientsTab> createState() => _IngredientsTabState();
}

class _IngredientsTabState extends State<IngredientsTab> {
  // For topping counts
  final Map<String, int> _toppingCounts = {
    'Beef': 0,
    'Smoked Beef': 1,
    'Mozarella Cheese': 1,
    'Mushroom': 1,
    'Paprika': 0,
  };

  // For size selection
  String _selectedSize = 'Medium';

  // For crust options
  final Map<String, int> _crustCounts = {
    'Classic Thin': 0,
    'New York Style Crust': 1,
    'Detroit Style': 0,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildAllergenInfo(),
              const SizedBox(height: 16),
              _buildToppingsAndSizes(),
              const SizedBox(height: 16),
              _buildExpandableContainer('Sub AAA', _buildExtraOptions()),
              const SizedBox(height: 16),
              _buildCommentBox(),
            ],
          ),
        ),
      ],
    );
  }

  // Allergen Information Section
  Widget _buildAllergenInfo() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "This product contains ingredients that may trigger allergies. Please review the ingredient list for details.",
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _AllergenChip(label: 'Eggs'),
            _AllergenChip(label: 'Fish'),
            _AllergenChip(label: 'Milk'),
            _AllergenChip(label: 'Mollusks'),
            _AllergenChip(label: 'Mustard'),
            _AllergenChip(label: 'Gluten'),
            Text(
              'See more >',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Toppings and Sizes Section
  Widget _buildToppingsAndSizes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Toppings',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildToppingsList(),
        const SizedBox(height: 16),
        const Text(
          'Choose Size',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildSizeOptions(),
        const SizedBox(height: 16),
        const Text(
          'Crust Options',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildCrustOptions(),
      ],
    );
  }

  // Toppings List
  Widget _buildToppingsList() {
    return Column(
      children: _toppingCounts.keys.map((label) {
        return _ToppingRow(
          label: label,
          count: _toppingCounts[label]!,
          onCountChanged: (newCount) {
            setState(() {
              _toppingCounts[label] = newCount;
            });
          },
        );
      }).toList(),
    );
  }

  // Size Options
  Widget _buildSizeOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: ['Small', 'Medium', 'Large'].map((size) {
        return _SizeOptionRow(
          label: size,
          isSelected: _selectedSize == size,
          onSelected: () {
            setState(() {
              _selectedSize = size;
            });
          },
        );
      }).toList(),
    );
  }

  // Crust Options
  Widget _buildCrustOptions() {
    return Column(
      children: _crustCounts.keys.map((label) {
        return _ToppingRow(
          label: label,
          count: _crustCounts[label]!,
          onCountChanged: (newCount) {
            setState(() {
              _crustCounts[label] = newCount;
            });
          },
        );
      }).toList(),
    );
  }

  // Expandable Container
  Widget _buildExpandableContainer(String title, Widget content) {
    return ExpansionTile(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      children: [content],
    );
  }

  // Extra Options
  Widget _buildExtraOptions() {
    return const Padding(
      padding: EdgeInsets.all(6),
      child: Text(
        "Extra sauces, drinks, or utensils can be added here.",
        style: TextStyle(fontSize: 14),
      ),
    );
  }

  // Comment Box Section
  Widget _buildCommentBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add Comments (Optional)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Write here',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}

// Topping Row
class _ToppingRow extends StatelessWidget {
  final String label;
  final int count;
  final ValueChanged<int> onCountChanged;

  const _ToppingRow({
    required this.label,
    required this.count,
    required this.onCountChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14)),
        Row(
          children: [
            IconButton(
              onPressed: () => onCountChanged(count > 0 ? count - 1 : 0),
              icon: const Icon(Icons.remove),
            ),
            Text(count.toString()),
            IconButton(
              onPressed: () => onCountChanged(count + 1),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}

// Size Option Row
class _SizeOptionRow extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  const _SizeOptionRow({
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Row(
        children: [
          Checkbox(value: isSelected, onChanged: (_) => onSelected()),
          Text(label),
        ],
      ),
    );
  }
}

// Allergen Chip Widget
class _AllergenChip extends StatelessWidget {
  final String label;

  const _AllergenChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.grey[200],
    );
  }
}
