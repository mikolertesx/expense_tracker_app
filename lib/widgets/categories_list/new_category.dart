import 'package:expense_tracker_app/models/category.dart';
import 'package:expense_tracker_app/views/icon_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewCategory extends StatefulWidget {
  const NewCategory(this.onAddCategory, {super.key});

  final void Function(Category category) onAddCategory;

  @override
  State<NewCategory> createState() {
    return _NewCategoryState();
  }
}

class _NewCategoryState extends State<NewCategory> {
  String svgImage = 'assets/icons/bookmark.svg';
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();

    super.dispose();
  }

  void _cancelExpense() {
    Navigator.of(context).pop();
  }

  void _getIcon() async {
    final data = await showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return const CategoryPicker();
        });

    if (data == null) return;
    setState(() {
      svgImage = data;
    });
  }

  // void _submitExpenseData() {
  //   final enteredAmount = double.tryParse(_amountController.text);
  //   final titleIsInvalid = _titleController.text.trim().isEmpty;
  //   final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
  //   final dateIsInvalid = _selectedDate == null;

  //   if (titleIsInvalid || amountIsInvalid || dateIsInvalid) {
  //     _showDialog();

  //     return;
  //   }

  //   widget.onAddExpense(Expense(
  //     amount: enteredAmount,
  //     category: _selectedCategory,
  //     date: _selectedDate!,
  //     title: _titleController.text,
  //   ));

  //   Navigator.pop(context);
  // }

  void _submitCategoryData() {
    widget.onAddCategory(
      Category(
        title: _titleController.text,
        image: svgImage,
      ),
    );

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
                InkWell(
                  onTap: _getIcon,
                  child: SvgPicture.asset(
                    svgImage,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                    height: 128,
                    width: 128,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: _cancelExpense,
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: _submitCategoryData,
                      child: const Text('Save Category'),
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
