import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagine_notes/core/constants/icons.dart';
import 'package:imagine_notes/core/constants/text_styles.dart';
import 'package:imagine_notes/features/home/presentation/bloc/note_bloc/notes_bloc.dart';
import 'package:imagine_notes/features/home/presentation/bloc/note_bloc/notes_state.dart';
import 'package:imagine_notes/features/home/presentation/widgets/note_card.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state is NotesLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NotesLoadSuccess) {
          final notes = state.notes;
          if (notes.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  AppIcons.travel,
                  const SizedBox(height: 10),
                  Text('No hay notas', style: AppTextStyle.bodyMedium),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: notes.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final note = notes[index];
              return NoteCard(note: note);
            },
          );
        } else if (state is NotesLoadFailure) {
          return Center(child: Text('Error: ${state.error}'));
        }
        return const SizedBox();
      },
    );
  }
}
