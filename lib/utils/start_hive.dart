import 'package:expense_tracker_app/models/expense.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> startHive() async {
  await Hive.initFlutter();
  // Add config options here.
  Hive.registerAdapter(ExpenseAdapter());
  await Hive.openBox<Expense>('expenses');
}
