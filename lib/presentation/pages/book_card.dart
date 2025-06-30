
import 'package:backbaseassignment/domain/entities/book.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final Book book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: book.thumbnailUrl != null
            ? Image.network(
                book.thumbnailUrl!,
                width: 50,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.book),
              )
            : const Icon(Icons.book, size: 50),
        title: Text(
          book.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          book.author.isNotEmpty ? book.author : 'Unknown Author',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/details',
            arguments: book.key,
          );
        },
      ),
    );
  }
}