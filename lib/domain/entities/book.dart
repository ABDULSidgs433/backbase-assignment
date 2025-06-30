import 'package:equatable/equatable.dart';
   class Book extends Equatable {
     final String title;
     final String author;
     final String? thumbnailUrl;
     final String key;
     const Book({
       required this.title,
       required this.author,
       this.thumbnailUrl,
       required this.key,
     });
     @override
     List<Object?> get props => [title, author, thumbnailUrl, key];
   }