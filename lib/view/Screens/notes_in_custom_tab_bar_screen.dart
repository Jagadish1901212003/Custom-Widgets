import 'package:custom_widgets/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'add_note_form_screen.dart';

class NoteModel {
  DateTime date;
  String note;

  NoteModel({required this.date, required this.note});
}

class NotesInCustomTabBarScreen extends StatefulWidget {
  const NotesInCustomTabBarScreen({super.key});

  // Static list to hold notes in memory while app runs
  static List<NoteModel> notes = [];

  @override
  State<NotesInCustomTabBarScreen> createState() =>
      _NotesInCustomTabBarScreenState();
}

class _NotesInCustomTabBarScreenState extends State<NotesInCustomTabBarScreen> {
  // Reference to the static notes list
  List<NoteModel> get notes => NotesInCustomTabBarScreen.notes;

  void _navigateToAddNote({NoteModel? note, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddNoteFormScreen(note: note)),
    );

    if (result != null && result is NoteModel) {
      setState(() {
        if (index != null) {
          notes[index] = result; // Editing existing note
        } else {
          notes.add(result); // Adding new note
        }
      });
    }
  }

  void _deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: ElevatedButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.appPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5), // border radius of 5
                ),
              ),
              onPressed: () => _navigateToAddNote(),
              child: const Text(
                '+ Add More',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ...notes.asMap().entries.map((entry) {
            final index = entry.key;
            final note = entry.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  margin: const EdgeInsets.only(top: 12, bottom: 4),
                  decoration: BoxDecoration(
                    color: AppColors.appPrimaryColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Note ${index + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _navigateToAddNote(note: note, index: index),
                  child: Container(
                    // color: Colors.white,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    // elevation: 4,
                    child: ListTile(
                      title: Text(
                        'Date: ${note.date.toLocal().toString().split(' ')[0]}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Note: ${note.note}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteNote(index),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }).toList(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
