import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app_v1/providers/favorite_meals_provider.dart';
import 'package:meals_app_v1/widgets/meal_details/meal_traits.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/meal.dart';
import '../widgets/list-view/list-view.dart';

class MealDetailsScreen extends ConsumerStatefulWidget {
  final Meal meal;

  const MealDetailsScreen({super.key, required this.meal});

  @override
  ConsumerState<MealDetailsScreen> createState() {
    return _MealDetailsState();
  }
}

class _MealDetailsState extends ConsumerState<MealDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    bool _isFavorite =
        ref.read(favoriteMealsProvider.notifier).isMealFavorite(widget.meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.title),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                ref
                    .read(favoriteMealsProvider.notifier)
                    .toggleMealFavoriteStatus(widget.meal);
              });
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                _isFavorite ? Icons.star : Icons.star_outline,
                key: ValueKey(_isFavorite),
              ),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: child,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: widget.meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(
                  widget.meal.imageUrl,
                ),
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
                  MealTraits(meal: widget.meal),
                  const SizedBox(
                    height: 12,
                  ),
                  MealDetailListView(
                    data: widget.meal.ingredients,
                    title: 'Ingredients',
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  MealDetailListView(
                    data: widget.meal.steps,
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
