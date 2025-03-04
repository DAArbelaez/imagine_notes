import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagine_notes/features/home/data/home_repository.dart';
import 'package:imagine_notes/features/home/domain/category.dart';
import 'category_event.dart';
import 'category_state.dart';

/// [CategoryBloc] manages category-related operations, handling state updates based on events.
///
/// The repository connection is maintained via a [StreamSubscription] to ensure real-time updates.
/// When a new category list is retrieved, it emits [CategoryLoadSuccess] with the updated list.
/// If an error occurs during retrieval, it emits [CategoryLoadFailure] with the error message.
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final HomeRepositoryImpl repository = HomeRepositoryImpl();
  StreamSubscription<List<Category>>? _subscription;

  CategoryBloc() : super(CategoryLoadInProgress()) {
    on<LoadCategories>(_onLoadCategories);
    on<CategoriesUpdated>((event, emit) {
      emit(CategoryLoadSuccess(event.categories));
    });
  }

  Future<void> _onLoadCategories(LoadCategories event, Emitter<CategoryState> emit) async {
    await _subscription?.cancel();
    _subscription = repository.getCategories().listen(
          (categories) => add(CategoriesUpdated(categories)),
          onError: (error) => emit(CategoryLoadFailure(error.toString())),
        );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
