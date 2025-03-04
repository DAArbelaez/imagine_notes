import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagine_notes/core/constants/palette.dart';
import 'package:imagine_notes/core/constants/text_styles.dart';
import 'package:imagine_notes/core/extensions/string_extensions.dart';
import 'package:imagine_notes/features/home/domain/category.dart';
import 'package:imagine_notes/features/home/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:imagine_notes/features/home/presentation/bloc/category_bloc/category_state.dart';

/// A widget that displays a list of category chips for filtering.
class CategoryChips extends StatelessWidget {
  final String? selectedCategoryId;
  final ValueChanged<String?> onCategorySelected;

  const CategoryChips({
    super.key,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryLoadInProgress) {
          return const SizedBox(
            height: 48,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is CategoryLoadSuccess) {
          final List<Widget> chips = [];

          /// "Todos" (All) chip to reset category selection.
          chips.add(
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ChoiceChip(
                label: Text('Todos', style: AppTextStyle.bodyMedium),
                selected: selectedCategoryId == null || selectedCategoryId!.isEmpty,
                onSelected: (_) => onCategorySelected(null),
              ),
            ),
          );

          // Generate chips dynamically based on the loaded categories.
          chips.addAll(state.categories.map((Category cat) {
            final chipColor = cat.color.toColor();
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ChoiceChip(
                label: Text(cat.name),
                selected: selectedCategoryId == cat.id,
                onSelected: (_) => onCategorySelected(cat.id),
                backgroundColor: Colors.grey[200],
                selectedColor: chipColor,
                checkmarkColor: Palette.white,
                labelStyle: AppTextStyle.bodyMedium.copyWith(
                  color: selectedCategoryId == cat.id ? Palette.white : Palette.textColor,
                ),
              ),
            );
          }));

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: chips),
          );
        } else if (state is CategoryLoadFailure) {
          return Text('Error: ${state.error}');
        }
        return const SizedBox();
      },
    );
  }
}
