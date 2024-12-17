import 'package:flutter/material.dart';

class NutritionalTab extends StatelessWidget {
  const NutritionalTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nutritional value per 100g',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NutritionalItem(value: '198', label: 'Kcal'),
              _NutritionalItem(value: '14.1', label: 'Proteins'),
              _NutritionalItem(value: '19.6', label: 'Fats'),
              _NutritionalItem(value: '6.6', label: 'Carbo H'),
            ],
          ),
        ],
      ),
    );
  }
}

class _NutritionalItem extends StatelessWidget {
  final String value;
  final String label;

  const _NutritionalItem({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}