import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app_v1/data/dummy_data.dart';
import 'package:meals_app_v1/providers/favorite_meals_provider.dart';
import 'package:meals_app_v1/providers/meal_provider.dart';
import 'package:meals_app_v1/screens/categories.dart';
import 'package:meals_app_v1/screens/filters/filter_screen.dart';
import 'package:meals_app_v1/screens/meals.dart';
import '../../providers/filters_provider.dart';
import '../../widgets/drawer/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}


class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setDrawerScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'filters') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const FilterScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filtersProvider);
    final availableMeals = meals.where((element) {
      if (activeFilters[Filter.glutenFree]! && !element.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.vegan]! && !element.isVegan) {
        return false;
      }
      if (activeFilters[Filter.vegetarian]! && !element.isVegetarian) {
        return false;
      }
      if (activeFilters[Filter.lactoseFree]! && !element.isLactoseFree) {
        return false;
      }
      return true;
    }).toList();
    Widget activePage = Categories(
      availableMeals: availableMeals,
    );
    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = Meals(
        meals: favoriteMeals,
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
