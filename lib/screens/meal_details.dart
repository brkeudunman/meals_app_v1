import 'package:flutter/material.dart';
import 'package:meals_app_v1/widgets/meal_details/meal_traits.dart';
import 'package:transparent_image/transparent_image.dart';
import '../models/meal.dart';
import '../widgets/list-view/list-view.dart';

class MealDetailsScreen extends StatefulWidget {
  final Meal meal;
  final void Function(Meal meal) onTapFavorite;

  const MealDetailsScreen(
      {super.key, required this.meal, required this.onTapFavorite});

  @override
  State<MealDetailsScreen> createState() {
    return _MealDetailsState();
  }
}

class _MealDetailsState extends State<MealDetailsScreen> {
  bool switchVar = false;

  void _switchVar() {
    if (switchVar) {
      setState(() {
        switchVar = false;
      });
    } else {
      setState(() {
        switchVar = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.title),
        actions: [
          IconButton(
            onPressed: () {
              widget.onTapFavorite(widget.meal);
              _switchVar();
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
                widget.meal.imageUrl,
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
