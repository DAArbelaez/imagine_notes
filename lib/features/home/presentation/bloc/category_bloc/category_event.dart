import 'package:equatable/equatable.dart';
import 'package:imagine_notes/features/home/domain/category.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
  @override
  List<Object?> get props => [];
}

class LoadCategories extends CategoryEvent {}

class CategoriesUpdated extends CategoryEvent {
  final List<Category> categories;
  const CategoriesUpdated(this.categories);

  @override
  List<Object?> get props => [categories];
}
