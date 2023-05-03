// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 2;

  @override
  Category read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Category(
      title: fields[0] as String,
      image: fields[1] as String,
      maxPrice: fields[2] as double?,
      color: fields[3] as Color?,
    )..expensesList = (fields[4] as List).cast<Expense>();
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.maxPrice)
      ..writeByte(3)
      ..write(obj.color)
      ..writeByte(4)
      ..write(obj.expensesList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
