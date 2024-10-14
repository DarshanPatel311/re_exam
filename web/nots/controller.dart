import 'package:get/get.dart';



import 'DB.dart';
import 'fierbase.dart';



class NoteController extends GetxController {
  var notes = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  final DBHelper _dbHelper = DBHelper();
  final FirebaseHelper _firebaseHelper = FirebaseHelper();

  @override
  void onInit() {
    super.onInit();
    loadNotes();
  }

  // Load notes from SQLite
  void loadNotes() async {
    isLoading.value = true;
    final dbNotes = await _dbHelper.getNotes();
    notes.assignAll(dbNotes);
    isLoading.value = false;
  }

  // Add new note
  void addNote(Map<String, dynamic> note) async {
    await _dbHelper.createNote(note);
    loadNotes();
  }

  // Update note
  void updateNote(int id, Map<String, dynamic> note) async {
    await _dbHelper.updateNote(id, note);
    loadNotes();
  }

  // Delete note
  void deleteNote(int id) async {
    await _dbHelper.deleteNote(id);
    loadNotes();
  }

  // Backup notes to Firebase
  void backupNotes() async {
    await _firebaseHelper.uploadNotes(notes);
  }

  // Restore notes from Firebase
  void restoreNotes() async {
    final cloudNotes = await _firebaseHelper.fetchNotes();
    for (var note in cloudNotes) {
      await _dbHelper.createNote(note);
    }
    loadNotes();
  }

  // Search and Filter Notes
  void searchNotes(String query) {
    final filteredNotes = notes.where((note) =>
    note['title'].toLowerCase().contains(query.toLowerCase()) ||
        note['content'].toLowerCase().contains(query.toLowerCase())).toList();
    notes.assignAll(filteredNotes);
  }

  // Sort notes by creation date or category
  void sortNotes(String criterion) {
    if (criterion == 'date') {
      notes.sort((a, b) => DateTime.parse(b['dateCreated']).compareTo(DateTime.parse(a['dateCreated'])));
    } else if (criterion == 'category') {
      notes.sort((a, b) => a['category'].compareTo(b['category']));
    }
  }
}