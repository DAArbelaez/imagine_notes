import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String name;
  final String color;

  const Category({
    required this.id,
    required this.name,
    required this.color,
  });

  factory Category.fromMap(Map<String, dynamic> data) {
    return Category(
      id: data['id'] as String? ?? '',
      name: data['name'] as String? ?? '',
      color: data['color'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color,
    };
  }

  Category copyWith({
    String? id,
    String? name,
    String? color,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
    );
  }

  @override
  List<Object?> get props => [id];
}
