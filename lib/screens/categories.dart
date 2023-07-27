import 'package:flutter/material.dart';
import 'package:meals_app_v1/data/dummy_data.dart';
import 'package:meals_app_v1/screens/meals.dart';
import 'package:meals_app_v1/widgets/category_grid_item.dart';

import '../models/category.dart';
import '../models/meal.dart';

class Categories extends StatelessWidget {
  final void Function(Meal meal) onTapFavorite;
  final List<Meal> availableMeals;

  const Categories(
      {super.key, required this.onTapFavorite, required this.availableMeals});

  void _selectedCategory(BuildContext context, Category category) {
    var filteredList = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) {
          return Meals(
            title: category.title,
            meals: filteredList,
            onTapFavorite: onTapFavorite,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 15,
      ),
      children: [
        ...availableCategories.map(
          (category) => CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _selectedCategory(context, category);
            },
          ),
        ),
      ],
    );
  }
}
