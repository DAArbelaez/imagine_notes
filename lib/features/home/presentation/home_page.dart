import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imagine_notes/core/constants/icons.dart';
import 'package:imagine_notes/core/constants/snackbar.dart';
import 'package:imagine_notes/core/constants/text_styles.dart';
import 'package:imagine_notes/core/navigation/routes.dart';
import 'package:imagine_notes/features/home/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:imagine_notes/features/home/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:imagine_notes/features/home/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:imagine_notes/features/home/presentation/bloc/category_bloc/category_bloc.dart';
import 'package:imagine_notes/features/home/presentation/bloc/category_bloc/category_event.dart';
import 'package:imagine_notes/features/home/presentation/bloc/note_bloc/notes_bloc.dart';
import 'package:imagine_notes/features/home/presentation/bloc/note_bloc/notes_event.dart';
import 'package:imagine_notes/features/home/presentation/widgets/category_chips.dart';
import 'package:imagine_notes/features/home/presentation/widgets/note_input_form.dart';
import 'package:imagine_notes/features/home/presentation/widgets/notes_list.dart';
import 'package:imagine_notes/features/home/presentation/widgets/notes_search_input.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedCategoryId;

  void _onCategorySelected(BuildContext context, String? categoryId) {
    setState(() {
      selectedCategoryId = categoryId;
    });
    context.read<NotesBloc>().add(LoadNotes(categoryId: categoryId));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(),
        ),
        BlocProvider(
          create: (_) => NotesBloc()..add(LoadNotes()),
        ),
        BlocProvider(
          create: (_) => CategoryBloc()..add(LoadCategories()),
        ),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            context.goNamed(Routes.signIn.name);
          }
          if (state is LogoutFailure) {
            CustomSnackBar.show(context, message: state.error);
          }
        },
        child: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                appBar: AppBar(
                  title: Text('Imagine Notes', style: AppTextStyle.titleMedium),
                  actions: [
                    IconButton(
                      icon: AppIcons.logout,
                      onPressed: () => context.read<AuthBloc>().add(LogoutRequested()),
                    ),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const NotesSearchInput(),
                      const SizedBox(height: 16),
                      CategoryChips(
                        selectedCategoryId: selectedCategoryId,
                        onCategorySelected: (categoryId) => _onCategorySelected(context, categoryId),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: const NoteInputForm(),
                              ),
                              const SizedBox(height: 16),
                              NotesList(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
