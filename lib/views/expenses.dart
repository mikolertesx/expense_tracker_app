import 'package:expense_tracker_app/widgets/chart/chart.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final expenseBox = Hive.box<Expense>(Expense.boxName);

  void _removeExpense(Expense expense) {
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
              expenseBox.add(expense);
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Expense>(Expense.boxName).listenable(),
      builder: (ctx, box, widget) {
        final expenses = box.values.toList();

        Widget mainContent = const Center(
          child: Text('No expenses found. Start adding some!'),
        );
        if (expenses.isNotEmpty) {
          mainContent = ExpensesList(
            expenses: expenses,
            onDismiss: _removeExpense,
          );
        }

        return Column(
          children: [
            Chart(expenses: expenses),
            Expanded(
              child: mainContent,
            ),
          ],
        );
      },
    );
  }
}
