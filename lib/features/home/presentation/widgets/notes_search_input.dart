import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagine_notes/core/constants/icons.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:imagine_notes/features/home/presentation/bloc/note_bloc/notes_bloc.dart';
import 'package:imagine_notes/features/home/presentation/bloc/note_bloc/notes_event.dart';

/// A search input field that allows users to filter notes dynamically.
class NotesSearchInput extends StatefulWidget {
  const NotesSearchInput({super.key});

  @override
  State<NotesSearchInput> createState() => _NotesSearchInputState();
}

class _NotesSearchInputState extends State<NotesSearchInput> {
  final FormGroup _form = FormGroup({
    'query': FormControl<String>(value: ''),
  });

  /// Timer to debounce search input and prevent unnecessary BloC events.
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _form.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      context.read<NotesBloc>().add(SearchQueryChanged(value));
    });
  }

  /// Clears the search input and resets the search query in the BloC.
  void _clearSearch() {
    _form.control('query').updateValue('');
    context.read<NotesBloc>().add(const SearchQueryChanged(''));
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: _form,
      child: ReactiveFormConsumer(
        builder: (context, form, child) {
          final currentValue = form.control('query').value as String? ?? '';
          return ReactiveTextField<String>(
            formControlName: 'query',
            decoration: InputDecoration(
              labelText: 'Buscar notas...',
              border: const OutlineInputBorder(),
              prefixIcon: AppIcons.search,
              suffixIcon: currentValue.isNotEmpty
                  ? IconButton(
                      icon: AppIcons.clear,
                      onPressed: _clearSearch,
                    )
                  : null,
            ),
            onChanged: (control) {
              if (control.value != null) _onSearchChanged(control.value!);
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(50),
            ],
          );
        },
      ),
    );
  }
}
