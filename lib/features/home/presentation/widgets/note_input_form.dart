import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagine_notes/core/constants/icons.dart';
import 'package:imagine_notes/features/common/presentation/buttons/custom_button.dart';
import 'package:imagine_notes/features/common/presentation/text_field/custom_reactive_input.dart';
import 'package:imagine_notes/features/home/domain/category.dart';
import 'package:imagine_notes/features/home/presentation/bloc/note_bloc/notes_bloc.dart';
import 'package:imagine_notes/features/home/presentation/bloc/note_bloc/notes_event.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'reactive_category_dropdown.dart';

class NoteInputForm extends StatefulWidget {
  const NoteInputForm({super.key});

  @override
  State<NoteInputForm> createState() => _NoteInputFormState();
}

class _NoteInputFormState extends State<NoteInputForm> {
  bool showForm = false;

  final FormGroup noteForm = FormGroup({
    'title': FormControl<String>(validators: [Validators.required]),
    'content': FormControl<String>(validators: [Validators.required]),
    'category': FormControl<Category>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showForm,
      replacement: SizedBox(
        width: double.infinity,
        child: CustomButton.primary(
          leftIcon: AppIcons.more,
          text: 'Agregar nota',
          onPressed: () {
            setState(() {
              showForm = true;
            });
          },
        ),
      ),
      child: ReactiveForm(
        formGroup: noteForm,
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            const ReactiveCategoryDropdown(
              formControlName: 'category',
            ),
            SizedBox(
              width: double.infinity,
              child: CustomButton.primary(
                text: 'Guardar Nota',
                onPressed: () => context.read<NotesBloc>().add(AddNote(form: noteForm)),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: CustomButton.secondary(
                text: 'Cancelar',
                onPressed: () {
                  setState(() {
                    showForm = false;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
