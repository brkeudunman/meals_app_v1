import 'package:flutter/material.dart';
import 'package:meals_app_v1/data/dummy_data.dart';
import 'package:meals_app_v1/screens/categories.dart';
import 'package:meals_app_v1/screens/filters/filter_screen.dart';
import 'package:meals_app_v1/screens/meals.dart';

import '../../models/meal.dart';
import '../../widgets/drawer/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

final Map<Filters, bool> initialValues = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegan: false,
  Filters.vegetarian: false,
};

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  List<Meal> _favoriteMeals = [];
  Map<Filters, bool> selectedFilters = initialValues;

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

  void _setDrawerScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'filters') {
      Map<Filters, bool> result = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FilterScreen(
            currentFilters: selectedFilters,
          ),
        ),
      );
      setState(() {
        selectedFilters = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((element) {
      if (selectedFilters[Filters.glutenFree]! && !element.isGlutenFree) {
        return false;
      }
      if (selectedFilters[Filters.vegan]! && !element.isVegan) {
        return false;
      }
      if (selectedFilters[Filters.vegetarian]! && !element.isVegetarian) {
        return false;
      }
      if (selectedFilters[Filters.lactoseFree]! && !element.isLactoseFree) {
        return false;
      }
      return true;
    }).toList();
    Widget activePage = Categories(
      availableMeals: availableMeals,
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
      drawer: MainDrawer(
        onTileClick: _setDrawerScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (idx) {
          _selectPage(idx);
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
