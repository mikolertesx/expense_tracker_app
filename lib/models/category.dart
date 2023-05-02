import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 2)
class Category extends HiveObject {
  Category({
    required this.title,
    required this.image,
    this.maxPrice,
    this.color,
  });

  static var boxName = 'categories';

  @HiveField(0)
  final String title;

  @HiveField(1)
  final String image;

  @HiveField(2)
  final double? maxPrice;

  @HiveField(3)
  final Color? color;
}
