import 'package:expense_tracker_app/views/category_picker.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.onAddExpense, {super.key});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String? _selectedIcon;
  DateTime? _selectedDate;
  final String _selectedCategory = '';

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    if (pickedDate == null) {
      return;
    }

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();

    super.dispose();
  }

  void _cancelExpense() {
    Navigator.of(context).pop();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Invalid input'),
        content: const Text(
          'Please make sure a valid title, amount, date and category was entered',
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'))
        ],
      ),
    );

    return;
  }

  Future<String?> _showIconPicker() {
    return showModalBottomSheet<String>(
        context: context,
        builder: (ctx) {
          return const CategoryPicker();
        });
  }

  void _updateIcon() async {
    final result = await _showIconPicker();
    if (result != null) {
      setState(() {
        _selectedIcon = result;
      });
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final titleIsInvalid = _titleController.text.trim().isEmpty;
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    final dateIsInvalid = _selectedDate == null;

    if (titleIsInvalid || amountIsInvalid || dateIsInvalid) {
      _showDialog();

      return;
    }

    widget.onAddExpense(Expense(
      amount: enteredAmount,
      category: _selectedCategory,
      date: _selectedDate!,
      title: _titleController.text,
    ));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        maxLength: 50,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: '\$ ',
                          label: Text('Amount'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'No date selected'
                                : formatter.format(
                                    _selectedDate!,
                                  ),
                          ),
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.date_range),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    IconButton(
                      onPressed: _updateIcon,
                      icon: const Icon(Icons.calendar_month),
                    ),
                    if (_selectedIcon != null) SvgPicture.asset(_selectedIcon!),
                    const Spacer(),
                    TextButton(
                      onPressed: _cancelExpense,
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: _submitExpenseData,
                      child: const Text('Save Expense'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
