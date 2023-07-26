import 'package:flutter/material.dart';
import 'package:meals_app_v1/widgets/meal_details/meal_traits.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/meal.dart';
import '../widgets/list-view/list-view.dart';

class MealDetailsScreen extends StatelessWidget {
  final Meal meal;
  final void Function(Meal meal) onTapFavorite;

  const MealDetailsScreen(
      {super.key, required this.meal, required this.onTapFavorite});

  @override
  Widget build(BuildContext context) {
    bool switchVar = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              onTapFavorite(meal);
              switchVar = !switchVar;
            },
            icon: Icon(switchVar == false ? Icons.star_border : Icons.star),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(
                meal.imageUrl,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  MealTraits(meal: meal),
                  const SizedBox(
                    height: 12,
                  ),
                  MealDetailListView(
                    data: meal.ingredients,
                    title: 'Ingredients',
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  MealDetailListView(
                    data: meal.steps,
                    title: 'Steps',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
