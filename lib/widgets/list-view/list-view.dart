import 'package:flutter/material.dart';

class MealDetailListView extends StatelessWidget {
  final List<String> data;
  final String title;

  const MealDetailListView({super.key, required this.data, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(
          height: 12,
        ),
        ...data.map(
          (val) {
            int idx = data.indexOf(val);
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor:
                          Theme.of(context).colorScheme.onBackground,
                      foregroundColor: Theme.of(context).colorScheme.background,
                      maxRadius: 16,
                      child: Text(
                        (idx + 1).toString(),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        softWrap: true,
                        overflow: TextOverflow.clip,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white.withOpacity(0.9),
                            ),
                        val,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            );
          },
        ),
      ],
    );
  }
}
