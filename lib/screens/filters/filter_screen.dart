import 'package:flutter/material.dart';

enum Filters {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterScreen extends StatefulWidget {
  final Map<Filters, bool> currentFilters;

  const FilterScreen({super.key, required this.currentFilters});

  @override
  State<FilterScreen> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegeterian = false;
  bool _vegan = false;

  @override
  void initState() {
    super.initState();
    _glutenFree = widget.currentFilters[Filters.glutenFree] ?? false;
    _vegeterian = widget.currentFilters[Filters.vegetarian] ?? false;
    _vegan = widget.currentFilters[Filters.vegan] ?? false;
    _lactoseFree = widget.currentFilters[Filters.lactoseFree] ?? false;
    print(widget.currentFilters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filters.glutenFree: _glutenFree,
            Filters.lactoseFree: _lactoseFree,
            Filters.vegan: _vegan,
            Filters.vegetarian: _vegeterian,
          });
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          child: Column(
            children: [
              SwitchListTile(
                value: _glutenFree,
                onChanged: (isChecked) {
                  setState(
                    () {
                      _glutenFree = isChecked;
                    },
                  );
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
                value: _lactoseFree,
                onChanged: (isChecked) {
                  setState(
                    () {
                      _lactoseFree = isChecked;
                    },
                  );
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
                value: _vegeterian,
                onChanged: (isChecked) {
                  setState(
                    () {
                      _vegeterian = isChecked;
                    },
                  );
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
                value: _vegan,
                onChanged: (isChecked) {
                  setState(
                    () {
                      _vegan = isChecked;
                    },
                  );
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
