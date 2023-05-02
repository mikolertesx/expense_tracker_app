import 'package:expense_tracker_app/models/category.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> startHive() async {
  await Hive.initFlutter();

  // Adapters
  Hive.registerAdapter(ExpenseAdapter());
  Hive.registerAdapter(CategoryAdapter());

  // Add config options here.
  await Hive.openBox<Expense>(Expense.boxName);
  await Hive.openBox<Category>(Category.boxName);
}
