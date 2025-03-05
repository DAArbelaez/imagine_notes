import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagine_notes/core/constants/icons.dart';
import 'package:imagine_notes/core/constants/palette.dart';
import 'package:imagine_notes/core/constants/snackbar.dart';
import 'package:imagine_notes/core/constants/text_styles.dart';
import 'package:imagine_notes/core/extensions/string_extensions.dart';
import 'package:imagine_notes/features/common/presentation/category_tag.dart';
import 'package:imagine_notes/features/common/presentation/text_field/custom_reactive_input.dart';
import 'package:imagine_notes/features/home/domain/category.dart';
import 'package:imagine_notes/features/home/domain/note.dart';
import 'package:imagine_notes/features/home/presentation/bloc/note_bloc/notes_bloc.dart';
import 'package:imagine_notes/features/home/presentation/bloc/note_bloc/notes_event.dart';
import 'package:imagine_notes/features/home/presentation/widgets/reactive_category_dropdown.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// [NoteCard] represents a single note displayed as a card.
/// It allows viewing and editing a note, with options to update or delete it.
class NoteCard extends StatefulWidget {
  final Note note;

  const NoteCard({super.key, required this.note});

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  bool _isEditing = false;
  late FormGroup _editForm;

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    _editForm = FormGroup({
      'title': FormControl<String>(
        value: widget.note.title,
        validators: [Validators.required],
      ),
      'content': FormControl<String>(
        value: widget.note.content,
        validators: [Validators.required],
      ),
      'category': FormControl<Category>(
        value: widget.note.category,
        validators: [Validators.required],
      ),
    });
  }

  /// Updates the form when the note data changes.
  @override
  void didUpdateWidget(covariant NoteCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.note != widget.note) {
      _initializeForm();
    }
  }

  void _cancelEditing() {
    setState(() {
      _isEditing = false;
    });
  }

  /// Updates the note with the new data from the form.
  void _confirmEditing() {
    context.read<NotesBloc>().add(
      UpdateNote(
        widget.note,
        _editForm,
        onSuccess: () {
          setState(() {
            _isEditing = false;
          });
        },
        onFailure: (error) => CustomSnackBar.show(context, message: error),
      ),
    );
  }

  @override
  void dispose() {
    _editForm.dispose();
    super.dispose();
  }

  /// Builds the UI based on whether the note is in edit mode or view mode.
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Palette.white,
      child: _isEditing ? _buildEditMode() : _buildViewMode(),
    );
  }

  Widget _buildViewMode() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.note.title,
            style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600),
          ),
          Text(widget.note.content, style: AppTextStyle.bodySmall),
          const SizedBox(height: 10),
          Row(
            children: [
              CategoryTag(
                tagName: widget.note.category.name,
                color: widget.note.category.color.toColor(),
              ),
              const Spacer(),
              IconButton(
                icon: AppIcons.edit,
                onPressed: () {
                  setState(() {
                    _isEditing = true;
                  });
                },
              ),
              IconButton(
                icon: AppIcons.delete,
                onPressed: () {
                  context.read<NotesBloc>().add(DeleteNote(widget.note.id));
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildEditMode() {
    return ReactiveForm(
      formGroup: _editForm,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 10,
          children: [
            CustomReactiveInput(
              formControlName: 'title',
              label: 'Título',
              validationMessages: {
                ValidationMessage.required: (_) => 'Este campo es requerido',
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
              ],
            ),
            CustomReactiveInput(
              formControlName: 'content',
              label: 'Contenido',
              validationMessages: {
                ValidationMessage.required: (_) => 'Este campo es requerido',
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(250),
              ],
            ),
            const ReactiveCategoryDropdown(formControlName: 'category'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 10,
              children: [
                TextButton(
                  onPressed: _cancelEditing,
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: _confirmEditing,
                  child: const Text('Confirmar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
