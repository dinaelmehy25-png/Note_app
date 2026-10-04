import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/note_controller.dart';
import '../../controllers/theme_controller.dart';
import 'widgets/custom_drawer.dart';
import 'widgets/note_card.dart';
import '../note_detail/note_detail_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final NoteController controller;
  final ThemeController themeController = Get.find<ThemeController>();
  final TextEditingController searchTextController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

 
  final RxBool isGrid = true.obs;

  @override
  void initState() {
    super.initState();
    controller = Get.put(NoteController());
  }
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
                        onChanged: (value) => controller.updateSearchQuery(value),
                        decoration: const InputDecoration(
                          hintText: 'Search your notes',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),

              
                    Obx(() => IconButton(
                          icon: Icon(
                            isGrid.value
                                ? Icons.view_agenda_outlined
                                : Icons.grid_view,
                          ),
                          onPressed: () => isGrid.toggle(),
                        )),

                   
                    IconButton(
                      icon: Icon(
                        isDark ? Icons.wb_sunny_outlined : Icons.nightlight_round_outlined,
                      ),
                      onPressed: () => themeController.toggleTheme(),
                    ),

                   
                    Obx(() {
                      if (controller.searchQuery.isNotEmpty) {
                        return IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            searchTextController.clear();
                            controller.updateSearchQuery('');
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
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),

           
            Expanded(
              child: Obx(() {
                final notesList = controller.notes;

                if (notesList.isEmpty) {
                  return const Center(
                    child: Text(
                      'No notes found',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: isGrid.value
                      ? GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                              Get.to(() => NoteDetailScreen(note: note));
                              },
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: notesList.length,
                          itemBuilder: (context, index) {
                            final note = notesList[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: NoteCard(
                                note: note,
                                onTap: () {
                                 Get.to(() => NoteDetailScreen(note: note));
                                },
                              ),
                            );
                          },
                        ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {
        Get.to(() => NoteDetailScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}