// lib/models/note.dart
class Note {
  final int? id;
  final String title;
  final String content;
  final DateTime dateTime;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.dateTime,
  });

  // Convert Note to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  // Create Note from Map
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      dateTime: DateTime.parse(map['dateTime']),
    );
  }
}