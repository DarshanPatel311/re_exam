import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';


class AddNoteScreen extends StatelessWidget {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String _category = 'Work';
  final NoteController _noteController = Get.find<NoteController>();

  void _saveNote() {
    final note = {
      'title': _titleController.text,
      'content': _contentController.text,
      'dateCreated': DateTime.now().toString(),
      'category': _category,
    };
    _noteController.addNote(note);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Content'),
            ),
            DropdownButton<String>(
              value: _category,
              onChanged: (String? newValue) {
                _category = newValue!;
              },
              items: <String>['Work', 'Personal', 'Miscellaneous']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _saveNote,
              child: Text('Save Note'),
            ),
          ],
        ),
      ),
    );
  }
}