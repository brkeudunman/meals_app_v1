import 'package:flutter/material.dart';
import 'package:meals_app_v1/screens/categories.dart';
import 'package:meals_app_v1/screens/meals.dart';

import '../../models/meal.dart';

class TabsScreen extends StatefulWidget {
  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  List<Meal> _favoriteMeals = [];

  void _handleAddFavorite(Meal meal) {
    final bool isExisting = _favoriteMeals.contains(meal);
    setState(() {
      isExisting ? _favoriteMeals.remove(meal) : _favoriteMeals.add(meal);
    });
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = Categories(
      onTapFavorite: _handleAddFavorite,
    );
    if (_selectedPageIndex == 1) {
      activePage = Meals(
        meals: _favoriteMeals,
        onTapFavorite: _handleAddFavorite,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedPageIndex == 0 ? "Categories" : "Favorites"),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          _selectPage(index);
        },
        items: const [
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.category),
              icon: Icon(Icons.category_outlined),
              label: "Categories"),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.star),
              icon: Icon(Icons.star_border),
              label: "Favorites"),
        ],
      ),
    );
  }
}
