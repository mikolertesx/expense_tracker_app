import 'package:flutter/material.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4.0),
            Row(
              children: [
                Text('\$ ${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    SvgPicture.asset(expense.category.image),
                    const SizedBox(width: 8),
                    Text(expense.formattedDate),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
