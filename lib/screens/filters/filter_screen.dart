import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app_v1/providers/filters_provider.dart';

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      body: WillPopScope(
        onWillPop: () async {
          ref.read(filtersProvider.notifier).setFilters(activeFilters);
          return true;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          child: Column(
            children: [
              SwitchListTile(
                value: activeFilters[Filter.glutenFree]!,
                onChanged: (isChecked) {
                  ref
                      .read(filtersProvider.notifier)
                      .setToggle(Filter.glutenFree, isChecked);
                },
                title: Text(
                  "Gluten-Free",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
                subtitle: Text(
                  "Only Gluten-Free meals",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ),
              SwitchListTile(
                value: activeFilters[Filter.lactoseFree]!,
                onChanged: (isChecked) {
                  ref
                      .read(filtersProvider.notifier)
                      .setToggle(Filter.lactoseFree, isChecked);
                },
                title: Text(
                  "Lactose-Free",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
                subtitle: Text(
                  "Lactose Gluten-Free meals",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ),
              SwitchListTile(
                value: activeFilters[Filter.vegetarian]!,
                onChanged: (isChecked) {
                  ref
                      .read(filtersProvider.notifier)
                      .setToggle(Filter.vegetarian, isChecked);
                },
                title: Text(
                  "Vegetarian",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
                subtitle: Text(
                  "Only Vegetarian meals",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ),
              SwitchListTile(
                value: activeFilters[Filter.vegan]!,
                onChanged: (isChecked) {
                  ref
                      .read(filtersProvider.notifier)
                      .setToggle(Filter.vegan, isChecked);
                },
                title: Text(
                  "Vegan",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
                subtitle: Text(
                  "Only vegan meals",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
