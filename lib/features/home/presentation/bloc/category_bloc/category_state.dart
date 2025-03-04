import 'package:equatable/equatable.dart';
import 'package:imagine_notes/features/home/domain/category.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object?> get props => [];
}

class CategoryLoadInProgress extends CategoryState {}

class CategoryLoadSuccess extends CategoryState {
  final List<Category> categories;

  const CategoryLoadSuccess(this.categories);

  @override
  List<Object?> get props => [categories];
}

class CategoryLoadFailure extends CategoryState {
  final String error;

  const CategoryLoadFailure(this.error);

  @override
  List<Object?> get props => [error];
}
