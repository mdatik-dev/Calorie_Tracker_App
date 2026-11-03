import 'package:flutter/material.dart';

import '../models/food_item.dart';

class FoodListItem extends StatelessWidget {
  const FoodListItem({
    super.key,
    required this.food,
    required this.onDelete,
    required this.formattedCalories,
  });

  final FoodItem food;
  final VoidCallback onDelete;
  final String formattedCalories;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        leading: Container(
          width: 43,
          height: 43,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF4EE),
            borderRadius: BorderRadius.circular(13),
          ),
          child: const Icon(Icons.restaurant_rounded,
              color: Color(0xFF16845B)),
        ),
        title: Text(
          food.name,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF18352A),
          ),
        ),
        subtitle: Text('$formattedCalories kcal',
            style: const TextStyle(color: Color(0xFF718078))),
        trailing: IconButton(
          tooltip: 'Delete food',
          onPressed: onDelete,
          icon: const Icon(Icons.delete_outline_rounded),
          color: const Color(0xFFD45A42),
        ),
      ),
    );
  }
}
