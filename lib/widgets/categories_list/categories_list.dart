import 'package:flutter/material.dart';
import './categories_item.dart';

import '../../models/category.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
    required this.categories,
    required this.onDismiss,
  });

  final void Function(Category category) onDismiss;

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (ctx, index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error,
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        key: ValueKey(categories[index]),
        onDismissed: (direction) {
          onDismiss(categories[index]);
        },
        child: CategoriesItem(
          categories[index],
        ),
      ),
    );
  }
}
