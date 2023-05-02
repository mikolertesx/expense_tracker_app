import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'expense.g.dart';

final formatter = DateFormat.yMd();

@HiveType(typeId: 1)
class Expense extends HiveObject {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  static var boxName = 'expenses';

  @HiveField(0)
  final String title;

  @HiveField(1)
  final double amount;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final String category;

  String get formattedDate {
    return formatter.format(date);
  }
}
