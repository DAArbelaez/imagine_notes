import 'package:cloud_firestore/cloud_firestore.dart';
import 'category.dart';

class Note {
  final String id;
  final String title;
  final String content;
  final Category category;
  final String ownerId;
  final DateTime? timestamp;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.ownerId,
    this.timestamp,
  });

  factory Note.fromMap(Map<String, dynamic> data) {
    return Note(
      id: data['id'] as String? ?? '',
      title: data['title'] as String? ?? '',
      content: data['content'] as String? ?? '',
      category: data['category'] != null
          ? Category.fromMap(data['category'] as Map<String, dynamic>)
          : Category(id: '', name: 'Sin categoría', color: '#FFFFFF'),
      ownerId: data['ownerId'] as String? ?? '',
      timestamp: data['timestamp'] != null ? (data['timestamp'] as Timestamp).toDate() : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'category': category.toMap(),
      'ownerId': ownerId,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }

  Note copyWith({
    String? id,
    String? title,
    String? content,
    Category? category,
    String? ownerId,
    DateTime? timestamp,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      ownerId: ownerId ?? this.ownerId,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
