import 'package:expense_tracker_app/models/category.dart';
import 'package:expense_tracker_app/views/categories.dart';
import 'package:expense_tracker_app/views/expenses.dart';
import 'package:expense_tracker_app/widgets/categories_list/new_category.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../widgets/expenses_list/new_expense.dart';
import '../models/expense.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final expenseBox = Hive.box<Expense>(Expense.boxName);
  final categoryBox = Hive.box<Category>(Category.boxName);
  int _selectedIndex = 0;
  void _addExpense(Expense expense) {
    setState(() {
      expenseBox.add(expense);
      final selectedCategory = expense.category;
      selectedCategory.expensesList.add(expense);

      selectedCategory.save();
    });
  }

  void _addcategory(Category category) {
    setState(() {
      categoryBox.add(category);
    });
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(_addExpense),
    );
  }

  void _openAddCategoryOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewCategory(_addcategory),
    );
  }

  late var viewActions = [
    [
      IconButton(
        onPressed: _openAddExpenseOverlay,
        icon: const Icon(Icons.add),
      ),
    ],
    [
      IconButton(
        onPressed: _openAddCategoryOverlay,
        icon: const Icon(Icons.add),
      ),
    ]
  ];

  final screenWidgets = [
    const Expenses(),
    const CreateCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Expense Tracker'),
          actions: viewActions[_selectedIndex],
        ),
        body: screenWidgets[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: 'Categories')
          ],
          onTap: (value) => setState(() => _selectedIndex = value),
          currentIndex: _selectedIndex,
        ),
      ),
    );
  }
}
