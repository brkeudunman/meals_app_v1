import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';


class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    if (isMealFavorite(meal)) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }

  bool isMealFavorite(Meal meal) {
    return state.contains(meal);
  }
}

final favoriteMealsProvider = StateNotifierProvider<FavoriteMealsNotifier,List<Meal>>(
  (ref) {
    return FavoriteMealsNotifier();
  },
);