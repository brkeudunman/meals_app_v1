import 'package:flutter/material.dart';

import '../../models/meal.dart';
import 'meal_item_trait.dart';

class MealTraits extends StatelessWidget {
  final Meal meal;

  const MealTraits({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Traits",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                ),
          ),
          Wrap(
            spacing: 8,
            direction: Axis.horizontal,
            children: [
              MailItemTrait(
                icon: meal.isGlutenFree ? Icons.add : Icons.remove,
                label: meal.isGlutenFree ? "Gluten Free" : "No Gluten Free",
              ),
              MailItemTrait(
                icon: meal.isLactoseFree ? Icons.add : Icons.remove,
                label: meal.isLactoseFree ? "Lactose Free" : "No Lactose Free",
              ),
              MailItemTrait(
                icon: meal.isVegan ? Icons.add : Icons.remove,
                label: meal.isVegan ? "Vegan" : "Not Vegan",
              ),
              MailItemTrait(
                icon: meal.isVegetarian ? Icons.add : Icons.remove,
                label: meal.isVegetarian ? "Vegetarian" : "Not Vegetarian",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
