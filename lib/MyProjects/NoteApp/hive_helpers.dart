import 'package:hive_flutter/adapters.dart';

class HiveHelpers {
  static const notesBox = "Notes";
  static const notesBoxKey = "notesBoxKey";

  static List<Map<String, String>> myNotes = [];
//add
  static void addnote(String text, String title) {
    myNotes.add({'title': title, 'content': text});

    Hive.box(notesBox).put(notesBoxKey, myNotes);
  }

// Get all notes
  static Future<dynamic> getAllNotes() async {
    myNotes = await Hive.box(notesBox).get(notesBoxKey);
  }

//delete
  static void removeNote(int index) {
    myNotes.removeAt(index);
    Hive.box(notesBox).put(notesBoxKey, myNotes);
  }

//update
  static updateNote(int index, String text, String title) {
    myNotes[index] = {'title': title, 'content': text};
    Hive.box(notesBox).put(notesBoxKey, myNotes);
  }
}
