import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:meals_app_v1/data/dummy_data.dart';
import 'package:meals_app_v1/screens/meals.dart';
import 'package:meals_app_v1/widgets/category_grid_item.dart';

import '../models/category.dart';
import '../models/meal.dart';

class Categories extends StatefulWidget {
  final List<Meal> availableMeals;

  const Categories({super.key, required this.availableMeals});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      animationBehavior: AnimationBehavior.normal,
      duration: const Duration(
        milliseconds: 100,
      ),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectedCategory(BuildContext context, Category category) {
    var filteredList = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) {
          return Meals(
            title: category.title,
            meals: filteredList,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      ),
      builder: (ctx, child) => SlideTransition(
        position: _animationController.drive(
          Tween(
            begin: const Offset(0, 0.1),
            end: const Offset(0, 0),
          ),
        ),
        child: child,
      ),
    );
  }
}
