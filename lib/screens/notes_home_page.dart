import 'package:flutter/material.dart';
import 'package:my_app/providers/app_settings_provider.dart';
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../helpers/database_helper.dart';

class NotesHomePage extends StatefulWidget {
  const NotesHomePage({super.key});

  @override
  State<NotesHomePage> createState() => _NotesHomePageState();
}

class _NotesHomePageState extends State<NotesHomePage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    try {
      final loadedNotes = await _databaseHelper.getNotes();
      setState(() {
        notes = loadedNotes;
      });
    } catch (e) {
      _showErrorDialog('Failed to load notes: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('දෝෂයකි'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('හරි'),
          ),
        ],
      ),
    );
  }

  Future<void> _addNewNote() async {
    try {
      await showDialog(
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
                  onChanged: (value) => newTitle = value,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: const InputDecoration(hintText: 'සටහන'),
                  maxLines: 3,
                  onChanged: (value) => newContent = value,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('අවලංගු කරන්න'),
              ),
              TextButton(
                onPressed: () async {
                  if (newTitle.isEmpty || newContent.isEmpty) {
                    _showErrorDialog('කරුණාකර සියලු තොරතුරු ඇතුළත් කරන්න');
                    return;
                  }
                  final note = Note(
                    title: newTitle,
                    content: newContent,
                    dateTime: DateTime.now(),
                  );
                  await _databaseHelper.insertNote(note);
                  await _loadNotes();
                  if (mounted) Navigator.pop(context);
                },
                child: const Text('සුරකින්න'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      _showErrorDialog('Failed to add note: $e');
    }
  }

  Future<void> _deleteNote(int index) async {
    try {
      if (notes[index].id != null) {
        await _databaseHelper.deleteNote(notes[index].id!);
        await _loadNotes();
      }
    } catch (e) {
      _showErrorDialog('Failed to delete note: $e');
    }
  }

  Future<void> _editNote(int index) async {
    try {
      await showDialog(
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
                  onChanged: (value) => editedTitle = value,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: const InputDecoration(hintText: 'සටහන'),
                  controller: TextEditingController(text: editedContent),
                  maxLines: 3,
                  onChanged: (value) => editedContent = value,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('අවලංගු කරන්න'),
              ),
              TextButton(
                onPressed: () async {
                  if (editedTitle.isEmpty || editedContent.isEmpty) {
                    _showErrorDialog('කරුණාකර සියලු තොරතුරු ඇතුළත් කරන්න');
                    return;
                  }
                  final updatedNote = Note(
                    id: notes[index].id,
                    title: editedTitle,
                    content: editedContent,
                    dateTime: DateTime.now(),
                  );
                  await _databaseHelper.updateNote(updatedNote);
                  await _loadNotes();
                  if (mounted) Navigator.pop(context);
                },
                child: const Text('යාවත්කාලීන කරන්න'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      _showErrorDialog('Failed to edit note: $e');
    }
  }

  
  @override
   Widget _buildLanguageMenu() {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      onSelected: (String code) {
        context.read<AppSettingsProvider>().setLanguage(code);
      },
      itemBuilder: (BuildContext context) {
        final l10n = context.read<AppSettingsProvider>().localizations;
        return [
          PopupMenuItem(
            value: 'en',
            child: Text(l10n.get('english')),
          ),
          PopupMenuItem(
            value: 'si',
            child: Text(l10n.get('sinhala')),
          ),
          PopupMenuItem(
            value: 'ta',
            child: Text(l10n.get('tamil')),
          ),
        ];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AppSettingsProvider>();
    final l10n = settings.localizations;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.get('appName')),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          _buildLanguageMenu(),
          IconButton(
            icon: Icon(settings.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () => settings.toggleTheme(),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: notes.isEmpty
                ? Center(
                    child: Text(l10n.get('noNotes')),
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
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(notes[index].content),
                              const SizedBox(height: 4),
                              Text(
                                '${l10n.get('created')}: ${notes[index].dateTime.toString().split('.')[0]}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${l10n.get('support')}: yasaspasindufernando@gmail.com',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    floatingActionButton: Padding(
      padding: const EdgeInsets.only(bottom: 60 ,right: 20), // Move FAB up
      child: FloatingActionButton(
        onPressed: _addNewNote,
        child: const Icon(Icons.add),
      ),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}