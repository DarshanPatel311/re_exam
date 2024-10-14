import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_not.dart';
import 'controller.dart';


class NoteListScreen extends StatelessWidget {
  final NoteController _noteController = Get.find<NoteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Get.to(() => AddNoteScreen());
            },
          ),
          IconButton(
            icon: Icon(Icons.cloud_upload),
            onPressed: _noteController.backupNotes,
          ),
          IconButton(
            icon: Icon(Icons.cloud_download),
            onPressed: _noteController.restoreNotes,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Notes',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _noteController.searchNotes(value);
              },
            ),
          ),
          Obx(() {
            if (_noteController.isLoading.value) {
              return CircularProgressIndicator();
            }
            return Expanded(
              child: ListView.builder(
                itemCount: _noteController.notes.length,
                itemBuilder: (context, index) {
                  final note = _noteController.notes[index];
                  return ListTile(
                    title: Text(note['title']),
                    subtitle: Text(note['category']),
                    onTap: () {
                      // Go to note edit screen
                    },
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _noteController.deleteNote(note['id']);
                      },
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}