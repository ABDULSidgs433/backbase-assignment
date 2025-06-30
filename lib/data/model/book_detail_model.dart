// lib/data/models/book_detail_model.dart
import 'package:backbaseassignment/domain/entities/book_detail.dart';

class BookDetailModel {
  final String key;
  final String title;
  final String? description;
  final List<int>? covers;
  final List<Map<String, dynamic>>? authors;

  BookDetailModel({
    required this.key,
    required this.title,
    this.description,
    this.covers,
    this.authors,
  });

  factory BookDetailModel.fromJson(Map<String, dynamic> json) {
    return BookDetailModel(
      key: json['key'] as String? ?? '',
      title: json['title'] as String? ?? 'Unknown Title',
      description: json['description'],
      covers: json['covers'] != null
          ? (json['covers'] as List).map((e) => e as int).toList()
          : null,
      authors: json['authors'] != null
          ? (json['authors'] as List).cast<Map<String, dynamic>>()
          : null,
    );
  }

  BookDetail toEntity() {
    return BookDetail(
      key: key,
      title: title,
      authors: _extractAuthorNames(),
      description: _extractDescription(),
      coverUrl: _getCoverUrl(),
    );
  }

  String? _getCoverUrl() {
    if (covers != null && covers!.isNotEmpty) {
      final coverId = covers!.first;
      return 'https://covers.openlibrary.org/b/id/$coverId-M.jpg';
    }
    return null;
  }

  String? _extractDescription() {
    if (description == null) return null;
    
    if (description is String) {
      return description as String;
    } else if (description is Map<String, dynamic>) {
      return description!;
    }
    
    return null;
  }

  List<String> _extractAuthorNames() {
    final List<String> names = [];
    
    if (authors != null) {
      for (final author in authors!) {
        if (author['name'] != null) {
          names.add(author['name'] as String);
        } else if (author['key'] != null) {
          // Extract name from key as fallback: /authors/OL123A -> OL123A
          final key = author['key'] as String;
          final parts = key.split('/');
          if (parts.isNotEmpty) {
            names.add(parts.last);
          }
        }
      }
    }
    
    return names;
  }
}