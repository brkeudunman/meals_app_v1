import 'package:flutter/material.dart';
import 'package:meals_app_v1/screens/meal_details.dart';
import 'package:meals_app_v1/widgets/meal_details/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  const MealItem({super.key, required this.meal});

  void _onMealItemClick(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) {
        return MealDetailsScreen(
          meal: meal,
        );
      }),
    );
  }

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 3,
      child: InkWell(
        onTap: () {
          _onMealItemClick(context, meal);
        },
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.maxFinite,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontSize: 20,
                                color: Colors.white.withOpacity(0.9),
                              ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MailItemTrait(
                          icon: Icons.schedule,
                          label: "${meal.duration} min",
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MailItemTrait(
                          icon: Icons.work_outline,
                          label: complexityText,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MailItemTrait(
                          icon: Icons.monetization_on_outlined,
                          label: affordabilityText,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
