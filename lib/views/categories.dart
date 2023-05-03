import 'package:expense_tracker_app/widgets/categories_list/categories_list.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/category.dart';

class CreateCategory extends StatefulWidget {
  const CreateCategory({super.key});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  final categoriesBox = Hive.box<Category>(Category.boxName);

  void _removeCategory(Category expense) {
    expense.delete();

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Expense successfully deleted',
        ),
        duration: const Duration(seconds: 6),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              categoriesBox.add(expense);
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: categoriesBox.listenable(),
      builder: (ctx, box, widget) {
        final categories = box.values.toList();

        Widget mainContent = const Center(
          child: Text('No categories found. Start adding some!'),
        );

        if (categories.isNotEmpty) {
          mainContent = CategoriesList(
            categories: categories,
            onDismiss: _removeCategory,
          );
        }

        return mainContent;
      },
    );
  }
}
