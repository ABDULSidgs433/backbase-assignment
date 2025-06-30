    import 'package:backbaseassignment/domain/entities/book.dart';

class BookModel {
      final String title;
      final String authorName;
      final String? coverId;
      final String key;
      BookModel({required this.title, required this.authorName, this.coverId, required this.key});
      factory BookModel.fromJson(Map<String, dynamic> json) {
        // Parse the JSON from Open Library
        // Note: The author_name might be a list, we take the first one or join if multiple.
        return BookModel(
          title: json['title'] ?? 'No Title',
          authorName: (json['author_name'] is List) ? (json['author_name'][0] ?? 'Unknown') : 'Unknown',
          coverId: json['cover_i']?.toString(), // cover_i is the cover ID, we can build the URL: https://covers.openlibrary.org/b/id/{coverId}-M.jpg
          key: json['key'] ?? '',
        );
      }
      Book toEntity() {
        return Book(
          title: title,
          author: authorName,
          thumbnailUrl: coverId != null ? 'https://covers.openlibrary.org/b/id/$coverId-M.jpg' : null,
          key: key,
        );
      }
    }