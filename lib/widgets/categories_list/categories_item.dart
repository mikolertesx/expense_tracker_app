import 'package:expense_tracker_app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoriesItem extends StatelessWidget {
  const CategoriesItem(this.category, {super.key});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SvgPicture.asset(category.image, width: 64, height: 64),
            ],
          ),
        ),
      ),
    );
  }
}
