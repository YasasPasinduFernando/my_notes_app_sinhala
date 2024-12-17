import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'සටහන් පොත',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const NotesHomePage(),
    );
  }
}

class Note {
  String title;
  String content;
  DateTime dateTime;

  Note({required this.title, required this.content, required this.dateTime});
}

class NotesHomePage extends StatefulWidget {
  const NotesHomePage({super.key});

  @override
  State<NotesHomePage> createState() => _NotesHomePageState();
}

class _NotesHomePageState extends State<NotesHomePage> {
  List<Note> notes = [];

  void _addNewNote() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTitle = '';
        String newContent = '';

        return AlertDialog(
          title: const Text('නව සටහන'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(hintText: 'මාතෘකාව'),
                onChanged: (value) {
                  newTitle = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'සටහන'),
                maxLines: 3,
                onChanged: (value) {
                  newContent = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('අවලංගු කරන්න'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  notes.add(Note(
                    title: newTitle,
                    content: newContent,
                    dateTime: DateTime.now(),
                  ));
                });
                Navigator.pop(context);
              },
              child: const Text('සුරකින්න'),
            ),
          ],
        );
      },
    );
  }

  void _deleteNote(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  void _editNote(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String editedTitle = notes[index].title;
        String editedContent = notes[index].content;

        return AlertDialog(
          title: const Text('සටහන සංස්කරණය කරන්න'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(hintText: 'මාතෘකාව'),
                controller: TextEditingController(text: editedTitle),
                onChanged: (value) {
                  editedTitle = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'සටහන'),
                controller: TextEditingController(text: editedContent),
                maxLines: 3,
                onChanged: (value) {
                  editedContent = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('අවලංගු කරන්න'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  notes[index].title = editedTitle;
                  notes[index].content = editedContent;
                });
                Navigator.pop(context);
              },
              child: const Text('යාවත්කාලීන කරන්න'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('මගේ සටහන් පොත'),
      ),
      body: notes.isEmpty
          ? const Center(
              child: Text('තවම සටහන් නැත'),
            )
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      notes[index].title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(notes[index].content),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editNote(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteNote(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}