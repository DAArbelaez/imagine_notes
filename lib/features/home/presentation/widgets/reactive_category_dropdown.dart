import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagine_notes/core/constants/text_styles.dart';
import 'package:imagine_notes/features/home/domain/category.dart';
import 'package:imagine_notes/features/home/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:imagine_notes/features/home/presentation/bloc/category_bloc/category_state.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveCategoryDropdown extends StatelessWidget {
  final String formControlName;

  const ReactiveCategoryDropdown({super.key, required this.formControlName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoadInProgress) {
          return const CircularProgressIndicator();
        } else if (state is CategoryLoadSuccess) {
          final items = state.categories
              .map((category) => DropdownMenuItem<Category>(
                    value: category,
                    child: Text(category.name, style: AppTextStyle.bodyMedium),
                  ))
              .toList();
          return ReactiveDropdownField<Category>(
            formControlName: formControlName,
            decoration: const InputDecoration(
              labelText: 'Categoría',
              border: OutlineInputBorder(),
            ),
            items: items,
            validationMessages: {
              ValidationMessage.required: (_) => 'Selecciona una categoría',
            },
          );
        } else if (state is CategoryLoadFailure) {
          return Text('Error: ${state.error}');
        }
        return const SizedBox();
      },
    );
  }
}
