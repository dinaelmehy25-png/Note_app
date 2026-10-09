import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/notes_cubit.dart';
import '../../cubits/notes_state.dart';
import '../../cubits/theme_cubit.dart';
import '../note_detail/note_detail_screen.dart';
import 'widgets/custom_drawer.dart';
import 'widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchTextController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isGrid = true;

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2C2C2C) : Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchTextController,
                        onChanged: (value) {
                          context.read<NotesCubit>().updateSearchQuery(value);
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search your notes',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isGrid
                            ? Icons.view_agenda_outlined
                            : Icons.grid_view,
                      ),
                      onPressed: () {
                        setState(() {
                          isGrid = !isGrid;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        isDark
                            ? Icons.wb_sunny_outlined
                            : Icons.nightlight_round_outlined,
                      ),
                      onPressed: () {
                        context.read<ThemeCubit>().toggleTheme();
                      },
                    ),
                    BlocBuilder<NotesCubit, NotesState>(
                      builder: (context, state) {
                        final cubit = context.read<NotesCubit>();
                        if (cubit.searchQuery.isNotEmpty) {
                          return IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              searchTextController.clear();
                              context.read<NotesCubit>().updateSearchQuery('');
                            },
                          );
                        }
                        return const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.deepOrange,
                            child: Text(
                              'D',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // عرض قائمة / شبكة الملاحظات باستخدام BlocBuilder
            Expanded(
              child: BlocBuilder<NotesCubit, NotesState>(
                builder: (context, state) {
                  if (state is NotesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is NotesError) {
                    return Center(child: Text(state.errorMessage));
                  } else if (state is NotesSuccess) {
                    final notesList = state.notes;

                    if (notesList.isEmpty) {
                      return const Center(
                        child: Text(
                          'No notes found',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: isGrid
                          ? GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.85,
                              ),
                              itemCount: notesList.length,
                              itemBuilder: (context, index) {
                                final note = notesList[index];
                                return NoteCard(
                                  note: note,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            NoteDetailScreen(note: note),
                                      ),
                                    );
                                  },
                                );
                              },
                            )
                          : ListView.builder(
                              itemCount: notesList.length,
                              itemBuilder: (context, index) {
                                final note = notesList[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 10.0,
                                  ),
                                  child: NoteCard(
                                    note: note,
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              NoteDetailScreen(note: note),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const NoteDetailScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}