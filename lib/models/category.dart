import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'category.g.dart';

final formatter = DateFormat.yMd();

@HiveType(typeId: 2)
class Category extends HiveObject {
  Category({
    required this.title,
    required this.image,
  });

  static var boxName = 'categories';

  @HiveField(0)
  final String title;

  @HiveField(1)
  final String image;
}
