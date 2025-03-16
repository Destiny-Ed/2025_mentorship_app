import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  final sharedPref = SharedPreferences.getInstance();

  Future saveCounterValue(int counter) async {
    final pref = await sharedPref;
    await pref.setInt('counter', counter);
  }

  Future<int> getCounterValue() async {
    final pref = await sharedPref;
    return pref.getInt('counter') ?? 0;
  }

  //note saving with shared preferences
  Future saveNote(List<String> value) async {
    final pref = await sharedPref;
    await pref.setStringList('note', value);
  }

  Future<List<String>> getNote() async {
    final pref = await sharedPref;
    return pref.getStringList('note') ?? [];
  }

  ///sqlite service
  ///
  Future<Database> initDatabase() async {
    final db = await openDatabase('notes.db', version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS notes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          note TEXT NOT NULL
        )
      ''');
    });
    return db;
  }

  Future<void> addNote(String note) async {
    final db = await initDatabase();
    await db.insert('notes', {'note': note});
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    final db = await initDatabase();
    final notes = await db.query('notes');
    return notes;
  }

  Future<void> deleteNote(int id) async {
    final db = await initDatabase();
    await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateNote(int id, String updatedNote) async {
    final db = await initDatabase();
    await db.update('notes', {'note': updatedNote}, where: 'id = ?', whereArgs: [id]);
  }
}
